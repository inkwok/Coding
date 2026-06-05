use std::fmt;
use std::process::exit;
use std::env;
use std::fs::File;
use std::io::{self, Read, Write};

const NAME: &str = "brainfuck";
const EXT: &str = ".bf";
type Word = u32;

#[derive(Debug, PartialEq)]
enum Tokens { Null, In, Out, Add, Sub, Left, Right, Jz, Jnz }

struct InstructionData {
    token: Tokens,
    argument: Option<usize>
}

impl fmt::Debug for InstructionData {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self.argument {
            Some(arg) => write!(f, "\x1b[1;33m{:?}->[{}]\x1b[0m", self.token, arg),
            None => write!(f, "{:?}", self.token),
        }
    }
}

struct ProgramData {
    array: Vec<InstructionData>,
    p: usize,
    size: usize
}

impl fmt::Debug for ProgramData {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        writeln!(f, "\n\x1b[1;32mInstructions:\x1b[0m")?;
        for (i, instruction) in self.array.iter().enumerate() {
            writeln!(f, "[{}]:\t{:?}", i, instruction)?;
        }
        writeln!(f, "\x1b[1;32mSize: {} tokens\x1b[0m", self.size)?;
        Ok(())
    }
}

struct MemoryData {
    array: Vec<Word>,
    p: usize,
    size: usize
}

struct Flags {
    debug: bool,
    verbose: bool,
}

macro_rules! append_program {
    ($name:ident, $token:path) => {{
        $name.array.push(InstructionData { token: $token, argument: None });
        $name.p += 1;
    }};
    ($name:ident, $token:path, $arg:expr) => {{
        $name.array.push(InstructionData { token: $token, argument: Some($arg) });
        $name.p += 1;
    }};
}

fn die_usage() -> ! {
    eprintln!("Usage: ./{NAME} [FILE]... [OPTIONS]...\nExecutes {NAME} programs.");
    eprintln!("  -d\t\t\tenters debug mode");
    eprintln!("  -v\t\t\tenters verbose mode");
    exit(0);
}

#[inline(always)]
fn interpret(program: &ProgramData, memory: &mut MemoryData, p: &mut usize) {
    match program.array[*p].token {
        Tokens::In    => if let Some(Ok(byte)) = io::stdin().lock().bytes().next() { memory.array[memory.p] = byte as Word; },
        Tokens::Out   => print!("{}", char::from_u32(memory.array[memory.p]).unwrap()),
        Tokens::Add   => memory.array[memory.p] += 1,
        Tokens::Sub   => memory.array[memory.p] -= 1,
        Tokens::Right => memory.p += 1,
        Tokens::Left  => memory.p -= 1,
        Tokens::Jz    => if memory.array[memory.p] == 0 { *p = program.array[*p].argument.unwrap(); },
        Tokens::Jnz   => if memory.array[memory.p] != 0 { *p = program.array[*p].argument.unwrap(); },
        Tokens::Null  => {}
    }
    let _ = io::stdout().flush();
}

#[inline(always)]
fn parse(program: &mut ProgramData, stack: &mut Vec<usize>, c: u8) -> Option<()> {
    match c {
        b'+' => append_program!(program, Tokens::Add),
        b'-' => append_program!(program, Tokens::Sub),
        b'<' => append_program!(program, Tokens::Left),
        b'>' => append_program!(program, Tokens::Right),
        b'.' => append_program!(program, Tokens::Out),
        b',' => append_program!(program, Tokens::In), 
        b'[' => {
            stack.push(program.p);
            append_program!(program, Tokens::Jz);
        },
        b']' => {
            let jp: usize = stack.pop()?;
            program.array[jp].argument = Some(program.p);
            append_program!(program, Tokens::Jnz, jp);
        },
        _    => {}
    }
    Some(())
}

fn run(program: ProgramData, flags: Flags) {
    let mut memory = MemoryData { array: Vec::new(), p: 0, size: 256 }; // 1 Kib
    let mut p: usize = 0;
    memory.array.resize(memory.size, 0);

    if flags.debug {
        println!("Beginning interpretation...");
        println!("\x1b[1;32mMemory size: {} KiB\x1b[0m", memory.size / 256); 
    }

    while program.array[p].token != Tokens::Null {
        interpret(&program, &mut memory, &mut p);
        p += 1;

        if memory.p == memory.size {
            memory.size *= 2;
            memory.array.resize(memory.size, 0);
            if flags.debug { println!("\n\x1b[1;32mMemory size: {} KiB\x1b[0m", memory.size / 256) }
        }
    }
}

fn cook(filename: &String, program: &mut ProgramData) -> Result<(), String> {
    let mut file = File::open(filename).map_err(|_| "File does not exist")?;
    let mut stack = Vec::new();
    let mut buffer = [0; 1];

    while file.read(&mut buffer).map_err(|e| format!("File I/O failure: {}", e))? != 0 {
        parse(program, &mut stack, buffer[0]).ok_or("Too many ']' symbols; stack popped while empty.")?;
    }
    append_program!(program, Tokens::Null);
    program.size = program.p;
    if !stack.is_empty() {
        return Err("Too many '[' symbols; stack is not empty on cook() completion.".to_string())
    }
    Ok(())
}

fn set_flags() -> Option<Flags> {
    let mut flags = Flags { debug: false, verbose: false };
    let options = env::args().next_back().unwrap();

    if !options.starts_with('-') { return None }
    if options.contains('d') { flags.debug = true; }
    if options.contains('v') { 
        flags.verbose = true;
        todo!("Verbose flag not implemented.");
    }
    Some(flags)
}

fn main() {
    let argument_count = env::args().count();
    if argument_count < 2 { die_usage(); }
    let filename = env::args().nth(1).unwrap();
    if !filename.ends_with(EXT) { die_usage(); }
    let mut program = ProgramData { array: Vec::new(), p: 0, size: 0 };
    let mut flags = Flags { debug: false, verbose: false };

    if argument_count > 2 { 
        flags = match set_flags() {
            Some(f) => f,
            None => die_usage()
        };
    }


    let status = cook(&filename, &mut program);
    if flags.debug {
        eprintln!("File to execute: {filename}"); 
        dbg!(&program); 
    }

    match status {
        Ok(()) => run(program, flags),
        Err(e) => eprintln!("\x1b[1;31mError: {e}\x1b[0m")
    };
}

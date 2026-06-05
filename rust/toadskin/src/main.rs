use std::fmt;
use std::process::exit;
use std::env;
use std::fs::File;
use std::io::{self, Read};

type Word = u32;
const FILE_EXTENSION: &str = ".td";

#[derive(Debug, PartialEq)]
enum Tokens {
    Null, In, Out, Add, Sub, Pop, Push, Jz, Jnz, Start, End, Swap
}

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
    program_array: Vec<InstructionData>,
    p: usize,
    size: usize,
    sequence_array: Vec<Vec<InstructionData>>
}

impl fmt::Debug for ProgramData {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        writeln!(f, "\n")?;
        for (i, instruction) in self.program_array.iter().enumerate() {
            writeln!(f, "[{}]\t{:?}", i, instruction)?;
        }
        writeln!(f, "size = {}", self.size)?;
        Ok(())
    }
}

macro_rules! append_program {
    ($name:ident, $token:path) => {{
        $name.program_array.push(InstructionData { token: $token, argument: None });
        $name.p += 1;
        $name.size += 1;
    }};
    ($name:ident, $token:path, $arg:expr) => {{
        $name.program_array.push(InstructionData { token: $token, argument: Some($arg) });
        $name.p +=1;
        $name.size += 1;
    }};
}

fn die_usage() -> ! {
    eprintln!("Usage: ./td [FILE]... [OPTIONS]...\nExecutes brainfuck programs.");
    exit(0);
}

#[inline(always)]
fn interpret(program: &ProgramData, memory: &mut MemoryData, p: &mut usize) {
    match program.program_array[*p].token {
        Tokens::In => if let Some(Ok(byte)) = io::stdin().lock().bytes().next() {
            memory.array[memory.p] = byte as Word
        },
        Tokens::Out => print!("{}", char::from_u32(memory.array[memory.p]).unwrap()),
        Tokens::Add => memory.array[memory.p] += 1,
        Tokens::Sub => memory.array[memory.p] -= 1,
        Tokens::Push => memory.p += 1,
        Tokens::Pop => memory.p -= 1,
        Tokens::Jz => if memory.array[memory.p] == 0 {
            *p = program.program_array[*p].argument.unwrap()
        },
        Tokens::Jnz => if memory.array[memory.p] != 0 {
            *p = program.program_array[*p].argument.unwrap()
        },
        Tokens::Start => todo!(),
        Tokens::End => todo!(),
        Tokens::Swap => todo!(),
        Tokens::Null => {}
    }
}

#[inline(always)]
fn parse(program: &mut ProgramData, stack: &mut Vec<usize>, c: u8) -> Option<()> {
    match c {
        b'+' => append_program!(program, Tokens::Add),
        b'-' => append_program!(program, Tokens::Sub),
        b'<' => append_program!(program, Tokens::Pop),
        b'>' => append_program!(program, Tokens::Push),
        b'.' => append_program!(program, Tokens::Out),
        b',' => append_program!(program, Tokens::In), 
        b'[' => {
            stack.push(program.p);
            append_program!(program, Tokens::Jz);
        },
        b']' => {
            let jp: usize = stack.pop()?;
            program.program_array[jp].argument = Some(program.p);
            append_program!(program, Tokens::Jnz, jp);
        },
        b'%' => append_program!(program, Tokens::Swap),
        b':' => program.sequence_array.push(Vec::new()),
        b';' => todo!(),
        _ => {}
    }
    Some(())
}

fn run(program: ProgramData, debug: bool) {
    let mut p: usize = 0;
    if debug {
        dbg!(&program);
        println!("Memory size: {} bytes", memory.size * 4);
    }
    while program.array[p].token != Tokens::Null {
        interpret(&program, &mut memory, &mut p);
        p += 1;
        if memory.p == memory.size {
            memory.size *= 2;
            memory.array.resize(memory.size, 0);
            if debug { println!("\nMemory size: {} bytes", memory.size * 4) }
        }
    }
}

fn cook(filename: String, program: &mut ProgramData) -> Option<()> {
    let mut file: File = File::open(filename).ok()?;
    let mut stack: Vec<usize> = Vec::new();
    let mut buffer = [0; 1];
    while file.read(&mut buffer).ok()? != 0 { parse(program, &mut stack, buffer[0])? }
    if !stack.is_empty() { return None }
    append_program!(program, Tokens::Null);
    Some(())
}

fn main() {
    if env::args().count() < 2 { die_usage() }
    let filename: String = env::args().nth(1).unwrap();
    if !filename.ends_with(FILE_EXTENSION) { die_usage() }
    let mut program = ProgramData { program_array: Vec::new(), p: 0, size: 0, sequence_array: Vec::new() };
    let mut debug: bool = false;
    if env::args().count() == 3 && env::args().nth(2).unwrap() == "-d" { debug = true; }
    match cook(filename, &mut program) {
        Some(()) => run(program, debug),
        None => eprintln!("Compilation failed.")
    };
}

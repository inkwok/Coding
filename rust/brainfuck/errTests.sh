cargo build;
./target/debug/brainfuck bf/file_non_exist.bf -d;
./target/debug/brainfuck bf/err_finishNonEmptyStack.bf -d;
./target/debug/brainfuck bf/err_popEmptyStack.bf -d;
cargo clean

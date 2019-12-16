use std::fs::File;
use std::io::{self, Read, Write};

#[derive(Debug, PartialEq)]
enum OpCode {
    Add,
    Multiply,
    Save,
    Output,
    Halt,
    JumpIfTrue,
    JumpIfFalse,
    LessThan,
    Equals,
    Invalid,
}

#[derive(Debug, PartialEq)]
enum Mode {
    Immediate,
    Position,
    Invalid,
}

fn main() {
    let input = parse_input(&read_input());
    part_one(input.clone());
    part_two(input);
}

fn part_one(original_input: Vec<i32>) {
    let mut input = original_input.clone();
    let mut instruction_pointer: usize = 0;

    for _ in 0..input.len() - 1 {
        if instruction_pointer > input.len() - 1 {
            break;
        }

        let opcode = get_opcode(input[instruction_pointer]);

        match opcode {
            OpCode::Save => {
                let number = get_input();
                let target_position = input[instruction_pointer + 1];
                input[target_position as usize] = number;
                instruction_pointer = instruction_pointer + 2;
            }
            OpCode::Add => {
                let argument_mode_one = get_argument_mode(input[instruction_pointer], 0);
                let argument_mode_two = get_argument_mode(input[instruction_pointer], 1);
                let target_position = input[instruction_pointer + 3];

                let argument_one = match argument_mode_one {
                    Mode::Position => input[input[instruction_pointer + 1] as usize],
                    Mode::Immediate => input[instruction_pointer + 1],
                    Mode::Invalid => return,
                };

                let argument_two = match argument_mode_two {
                    Mode::Position => input[input[instruction_pointer + 2] as usize],
                    Mode::Immediate => input[instruction_pointer + 2],
                    Mode::Invalid => return,
                };

                let result = argument_one + argument_two;

                input[target_position as usize] = result;
                instruction_pointer = instruction_pointer + 4;
            }
            OpCode::Multiply => {
                let argument_mode_one = get_argument_mode(input[instruction_pointer], 0);
                let argument_mode_two = get_argument_mode(input[instruction_pointer], 1);
                let target_position = input[instruction_pointer + 3];

                let argument_one = match argument_mode_one {
                    Mode::Position => input[input[instruction_pointer + 1] as usize],
                    Mode::Immediate => input[instruction_pointer + 1],
                    Mode::Invalid => return,
                };

                let argument_two = match argument_mode_two {
                    Mode::Position => input[input[instruction_pointer + 2] as usize],
                    Mode::Immediate => input[instruction_pointer + 2],
                    Mode::Invalid => return,
                };

                let result = argument_one * argument_two;

                input[target_position as usize] = result;
                instruction_pointer = instruction_pointer + 4;
            }
            OpCode::Output => {
                output(instruction_pointer + 1, &input);
                instruction_pointer = instruction_pointer + 2;
            }
            OpCode::Halt => return,
            _ => return,
        }
    }
}

fn part_two(original_input: Vec<i32>) {
    let mut input = original_input.clone();
    let mut instruction_pointer: usize = 0;

    for _ in 0..input.len() - 1 {
        if instruction_pointer > input.len() - 1 {
            break;
        }

        let opcode = get_opcode(input[instruction_pointer]);

        match opcode {
            OpCode::Save => {
                let number = get_input();
                let target_position = input[instruction_pointer + 1];
                input[target_position as usize] = number;
                instruction_pointer = instruction_pointer + 2;
            }
            OpCode::Add => {
                let argument_mode_one = get_argument_mode(input[instruction_pointer], 0);
                let argument_mode_two = get_argument_mode(input[instruction_pointer], 1);
                let target_position = input[instruction_pointer + 3];

                let argument_one = match argument_mode_one {
                    Mode::Position => input[input[instruction_pointer + 1] as usize],
                    Mode::Immediate => input[instruction_pointer + 1],
                    Mode::Invalid => return,
                };

                let argument_two = match argument_mode_two {
                    Mode::Position => input[input[instruction_pointer + 2] as usize],
                    Mode::Immediate => input[instruction_pointer + 2],
                    Mode::Invalid => return,
                };

                let result = argument_one + argument_two;

                input[target_position as usize] = result;
                instruction_pointer = instruction_pointer + 4;
            }
            OpCode::Multiply => {
                let argument_mode_one = get_argument_mode(input[instruction_pointer], 0);
                let argument_mode_two = get_argument_mode(input[instruction_pointer], 1);
                let target_position = input[instruction_pointer + 3];

                let argument_one = match argument_mode_one {
                    Mode::Position => input[input[instruction_pointer + 1] as usize],
                    Mode::Immediate => input[instruction_pointer + 1],
                    Mode::Invalid => return,
                };

                let argument_two = match argument_mode_two {
                    Mode::Position => input[input[instruction_pointer + 2] as usize],
                    Mode::Immediate => input[instruction_pointer + 2],
                    Mode::Invalid => return,
                };

                let result = argument_one * argument_two;

                input[target_position as usize] = result;
                instruction_pointer = instruction_pointer + 4;
            }
            OpCode::JumpIfTrue => {
                let argument_mode_one = get_argument_mode(input[instruction_pointer], 0);
                let argument_one = match argument_mode_one {
                    Mode::Position => input[input[instruction_pointer + 1] as usize],
                    Mode::Immediate => input[instruction_pointer + 1],
                    Mode::Invalid => return,
                };

                let target_mode = get_argument_mode(input[instruction_pointer], 1);
                let target_position = match target_mode {
                    Mode::Position => input[input[instruction_pointer + 2] as usize],
                    Mode::Immediate => input[instruction_pointer + 2],
                    Mode::Invalid => return,
                };

                if argument_one != 0 {
                    instruction_pointer = target_position as usize;
                } else {
                    instruction_pointer = instruction_pointer + 3;
                }
            }
            OpCode::JumpIfFalse => {
                let argument_mode_one = get_argument_mode(input[instruction_pointer], 0);
                let argument_one = match argument_mode_one {
                    Mode::Position => input[input[instruction_pointer + 1] as usize],
                    Mode::Immediate => input[instruction_pointer + 1],
                    Mode::Invalid => return,
                };

                let target_mode = get_argument_mode(input[instruction_pointer], 1);
                let target_position = match target_mode {
                    Mode::Position => input[input[instruction_pointer + 2] as usize],
                    Mode::Immediate => input[instruction_pointer + 2],
                    Mode::Invalid => return,
                };

                if argument_one == 0 {
                    instruction_pointer = target_position as usize;
                } else {
                    instruction_pointer = instruction_pointer + 3;
                }
            }
            OpCode::LessThan => {
                let argument_mode_one = get_argument_mode(input[instruction_pointer], 0);
                let argument_mode_two = get_argument_mode(input[instruction_pointer], 1);
                let target_position = input[instruction_pointer + 3];

                let argument_one = match argument_mode_one {
                    Mode::Position => input[input[instruction_pointer + 1] as usize],
                    Mode::Immediate => input[instruction_pointer + 1],
                    Mode::Invalid => return,
                };

                let argument_two = match argument_mode_two {
                    Mode::Position => input[input[instruction_pointer + 2] as usize],
                    Mode::Immediate => input[instruction_pointer + 2],
                    Mode::Invalid => return,
                };

                if argument_one < argument_two {
                    input[target_position as usize] = 1;
                } else {
                    input[target_position as usize] = 0;
                }

                instruction_pointer = instruction_pointer + 4;
            }
            OpCode::Equals => {
                let argument_mode_one = get_argument_mode(input[instruction_pointer], 0);
                let argument_mode_two = get_argument_mode(input[instruction_pointer], 1);
                let target_position = input[instruction_pointer + 3];

                let argument_one = match argument_mode_one {
                    Mode::Position => input[input[instruction_pointer + 1] as usize],
                    Mode::Immediate => input[instruction_pointer + 1],
                    Mode::Invalid => return,
                };

                let argument_two = match argument_mode_two {
                    Mode::Position => input[input[instruction_pointer + 2] as usize],
                    Mode::Immediate => input[instruction_pointer + 2],
                    Mode::Invalid => return,
                };

                if argument_one == argument_two {
                    input[target_position as usize] = 1;
                } else {
                    input[target_position as usize] = 0;
                }

                instruction_pointer = instruction_pointer + 4;
            }
            OpCode::Output => {
                let argument_mode_one = get_argument_mode(input[instruction_pointer], 0);
                let argument_one = match argument_mode_one {
                    Mode::Position => input[input[instruction_pointer + 1] as usize],
                    Mode::Immediate => input[instruction_pointer + 1],
                    Mode::Invalid => return,
                };

                println!("{}", argument_one);
                instruction_pointer = instruction_pointer + 2;
            }
            OpCode::Halt => return,
            _ => return,
        }
    }
}

fn get_input() -> i32 {
    print!("Input number: ");
    io::stdout().flush().unwrap();
    let mut input_text = String::new();
    io::stdin()
        .read_line(&mut input_text)
        .expect("failed to read from stdin");

    let trimmed = input_text.trim();
    trimmed.parse::<i32>().unwrap()
}

fn output(index: usize, input: &Vec<i32>) {
    let index = input[index];
    println!("{}", input[index as usize])
}

fn get_opcode(instruction: i32) -> OpCode {
    if instruction < 10 {
        match instruction {
            1 => return OpCode::Add,
            2 => return OpCode::Multiply,
            3 => return OpCode::Save,
            4 => return OpCode::Output,
            5 => return OpCode::JumpIfTrue,
            6 => return OpCode::JumpIfFalse,
            7 => return OpCode::LessThan,
            8 => return OpCode::Equals,
            _ => return OpCode::Invalid,
        }
    }

    let input_string = instruction.to_string();
    let last_two_chars_reversed = input_string.chars().rev().take(2).collect::<Vec<char>>();
    let digit_chars = last_two_chars_reversed.iter().rev().collect::<Vec<_>>();
    let digits = digit_chars
        .iter()
        .map(|v| v.to_digit(10).unwrap())
        .collect::<Vec<u32>>();

    let opcode = digits[0] * 10 + digits[1];

    match opcode {
        01 => OpCode::Add,
        02 => OpCode::Multiply,
        03 => OpCode::Save,
        04 => OpCode::Output,
        05 => OpCode::JumpIfTrue,
        06 => OpCode::JumpIfFalse,
        07 => OpCode::LessThan,
        08 => OpCode::Equals,
        99 => OpCode::Halt,
        _ => OpCode::Invalid,
    }
}

fn get_argument_mode(instruction: i32, argument: i8) -> Mode {
    let modes = instruction
        .to_string()
        .chars()
        .rev()
        .skip(2)
        .collect::<Vec<char>>();

    if argument as usize >= modes.len() {
        return Mode::Position;
    }

    match modes[argument as usize] {
        '0' => Mode::Position,
        '1' => Mode::Immediate,
        _ => Mode::Invalid,
    }
}

fn parse_input(input: &str) -> Vec<i32> {
    let parsed: Vec<i32> = input
        .split(',')
        .collect::<Vec<&str>>()
        .iter()
        .map(|v| v.to_string().trim().parse::<i32>().unwrap())
        .collect::<Vec<i32>>();

    parsed
}

fn read_input() -> String {
    let mut file = File::open("input.txt").expect("Could not find file");
    let mut contents = String::new();
    file.read_to_string(&mut contents)
        .expect("Could not read file");
    contents
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    pub fn test_get_opcode() {
        assert_eq!(get_opcode(1234), OpCode::Invalid);
        assert_eq!(get_opcode(34), OpCode::Invalid);
        assert_eq!(get_opcode(1201), OpCode::Add);
        assert_eq!(get_opcode(1202), OpCode::Multiply);
        assert_eq!(get_opcode(1203), OpCode::Save);
        assert_eq!(get_opcode(1204), OpCode::Output);
        assert_eq!(get_opcode(1299), OpCode::Halt);
        assert_eq!(get_opcode(3), OpCode::Save);
        assert_eq!(get_opcode(1), OpCode::Add);
        assert_eq!(get_opcode(8), OpCode::Equals);
        assert_eq!(get_opcode(1008), OpCode::Equals);
    }

    #[test]
    pub fn test_get_argument_mode() {
        assert_eq!(get_argument_mode(12045, 0), Mode::Position);
        assert_eq!(get_argument_mode(12145, 0), Mode::Immediate);
        assert_eq!(get_argument_mode(12445, 0), Mode::Invalid);
        assert_eq!(get_argument_mode(10345, 1), Mode::Position);
        assert_eq!(get_argument_mode(11345, 1), Mode::Immediate);
        assert_eq!(get_argument_mode(13345, 1), Mode::Invalid);
        assert_eq!(get_argument_mode(03345, 2), Mode::Position);
        assert_eq!(get_argument_mode(13345, 2), Mode::Immediate);
        assert_eq!(get_argument_mode(23345, 2), Mode::Invalid);
        assert_eq!(get_argument_mode(3, 2), Mode::Position);
    }
}

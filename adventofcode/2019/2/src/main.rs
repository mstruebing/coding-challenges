use std::fs::File;
use std::io::prelude::*;

fn main() {
    let input_string = read_input();
    let input = parse_input(&input_string);

    part_one(input.clone());
    part_two(input);
}

fn part_one(mut input: Vec<i32>) {
    let instruction_length = 4;
    input[1] = 12;
    input[2] = 2;

    for idx in 0..input.len() - 1 {
        if idx % instruction_length == 0 {
            if input[idx] == 1 {
                let operant_one_position: usize = input[idx + 1] as usize;
                let operant_two_position: usize = input[idx + 2] as usize;
                let result_position: usize = input[idx + 3] as usize;
                let result = input[operant_one_position] + input[operant_two_position];

                input[result_position] = result;
            } else if input[idx] == 2 {
                let operant_one_position: usize = input[idx + 1] as usize;
                let operant_two_position: usize = input[idx + 2] as usize;
                let result_position: usize = input[idx + 3] as usize;

                let result = input[operant_one_position] * input[operant_two_position];
                input[result_position] = result;
            } else {
                break;
            }
        }
    }

    println!("part one: {:?}", input[0]);
}

fn part_two(original_input: Vec<i32>) {
    let instruction_length = 4;

    for i in 0..99 {
        for j in 0..99 {
            let mut input = original_input.clone();
            input[1] = i;
            input[2] = j;

            for idx in 0..input.len() - 1 {
                if idx % instruction_length == 0 {
                    if input[idx] == 1 {
                        let operant_one_position: usize = input[idx + 1] as usize;
                        let operant_two_position: usize = input[idx + 2] as usize;
                        let result_position: usize = input[idx + 3] as usize;
                        let result = input[operant_one_position] + input[operant_two_position];

                        input[result_position] = result;

                        if result == 19690720 {
                            println!("{}", 100 * i + j);
                        }
                    } else if input[idx] == 2 {
                        let operant_one_position: usize = input[idx + 1] as usize;
                        let operant_two_position: usize = input[idx + 2] as usize;
                        let result_position: usize = input[idx + 3] as usize;
                        let result = input[operant_one_position] * input[operant_two_position];

                        input[result_position] = result;

                        if result == 19690720 {
                            println!("{}", 100 * i + j);
                        }
                    } else {
                        break;
                    }
                }
            }
        }
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

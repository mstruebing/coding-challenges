use nom::IResult;

use crate::days::Day;

pub struct Day06;

#[derive(Debug)]
pub enum Operation {
    ADD,
    MUL,
}

type Number = u64;

impl Day for Day06 {
    type Input = String;

    fn parse(input: &str) -> IResult<&str, Self::Input> {
        Ok(("", input.to_owned()))
    }
    type Output1 = u64;

    fn part_1(input: &Self::Input) -> Self::Output1 {
        let (_, real_input) = parse(input).unwrap();
        let mut res = 0;

        for (operation, numbers) in real_input.iter() {
            res += match operation {
                Operation::ADD => numbers.iter().sum(),
                Operation::MUL => numbers.iter().fold(1, |acc, curr| acc * curr),
            };
        }

        res
    }

    type Output2 = u64;

    fn part_2(input: &Self::Input) -> Self::Output2 {
        let (_, real_input) = parse2(input).unwrap();
        let mut res = 0;

        for (operation, nums) in real_input.iter() {
            let real_nums = get_numbers(nums);

            res += match operation {
                Operation::ADD => real_nums.iter().sum(),
                Operation::MUL => real_nums.iter().fold(1, |acc, curr| acc * curr),
            };
        }

        res
    }
}

fn get_numbers(n: &Vec<String>) -> Vec<Number> {
    let mut res: Vec<Number> = vec![];

    let longest = n.iter().map(|n| n.len()).max().unwrap();

    for i in 0..longest {
        let n = get_number_for_index(n, i);
        // this is a hack because my parser sucks
        if n != 0 {
            res.push(n);
        }
    }

    res
}

fn get_number_for_index(nums: &Vec<String>, index: usize) -> Number {
    let digits: Number = nums
        .into_iter()
        .filter_map(|n| n.chars().nth(index))
        .filter_map(|c| c.to_digit(10))
        .fold(0, |acc, elem| acc * 10 + elem as u64);

    digits
}

fn parse(input: &str) -> IResult<&str, Vec<(Operation, Vec<Number>)>> {
    let lines: Vec<&str> = input.lines().filter(|l| !l.trim().is_empty()).collect();
    let op_line = lines.last().unwrap();
    let number_lines = &lines[..lines.len() - 1];

    let col_starts: Vec<usize> = op_line
        .char_indices()
        .filter(|&(_, c)| !c.is_whitespace())
        .map(|(i, _)| i)
        .collect();

    let ops: Vec<Operation> = col_starts
        .iter()
        .map(|&i| match op_line.chars().nth(i).unwrap() {
            '*' => Operation::MUL,
            '+' => Operation::ADD,
            _ => unreachable!(),
        })
        .collect();

    let cols: Vec<Vec<Number>> = col_starts
        .iter()
        .enumerate()
        .map(|(col_idx, &start)| {
            let end = if col_idx + 1 < col_starts.len() {
                col_starts[col_idx + 1]
            } else {
                number_lines[0].len()
            };
            number_lines
                .iter()
                .map(|line| line.get(start..end).unwrap_or("").trim())
                .filter(|s| !s.is_empty())
                .map(|s| s.parse::<Number>().unwrap())
                .collect()
        })
        .collect();

    let result = ops.into_iter().zip(cols.into_iter()).collect();
    Ok(("", result))
}

fn parse2(input: &str) -> IResult<&str, Vec<(Operation, Vec<String>)>> {
    let lines: Vec<&str> = input.lines().filter(|l| !l.trim().is_empty()).collect();

    let op_line = lines.last().unwrap();
    let number_lines = &lines[..lines.len() - 1];

    let col_starts: Vec<usize> = op_line
        .char_indices()
        .filter(|&(_, c)| !c.is_whitespace())
        .map(|(i, _)| i)
        .collect();

    let ops: Vec<Operation> = col_starts
        .iter()
        .map(|&i| match op_line.chars().nth(i).unwrap() {
            '*' => Operation::MUL,
            '+' => Operation::ADD,
            _ => unreachable!(),
        })
        .collect();

    let cols: Vec<Vec<String>> = col_starts
        .iter()
        .enumerate()
        .map(|(col_idx, &start)| {
            let end = if col_idx + 1 < col_starts.len() {
                col_starts[col_idx + 1]
            } else {
                number_lines[0].len()
            };
            number_lines
                .iter()
                .map(|line| line.get(start..end).unwrap_or("").to_string())
                .collect()
        })
        .collect();

    let result = ops.into_iter().zip(cols.into_iter()).collect();

    Ok(("", result))
}

mod tests {
    #[allow(unused_imports)]
    use super::*;

    #[test]
    fn test_get_number_for_index() {
        let a: Vec<String> = vec!["64 ".to_string(), "23 ".to_string(), "314".to_string()];
        assert_eq!(get_number_for_index(&a, 0), 623);
        assert_eq!(get_number_for_index(&a, 1), 431);
        assert_eq!(get_number_for_index(&a, 2), 4);
        assert_eq!(get_number_for_index(&a, 3), 0);

        let b: Vec<String> = vec![" 51 ".to_string(), "387 ".to_string(), "215 ".to_string()];
        assert_eq!(get_number_for_index(&b, 0), 32);
        assert_eq!(get_number_for_index(&b, 1), 581);
        assert_eq!(get_number_for_index(&b, 2), 175);

        let c: Vec<String> = vec!["328 ".to_string(), "64  ".to_string(), "98  ".to_string()];
        assert_eq!(get_number_for_index(&c, 0), 369);
        assert_eq!(get_number_for_index(&c, 1), 248);
        assert_eq!(get_number_for_index(&c, 2), 8);
    }
}

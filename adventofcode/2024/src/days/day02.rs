use nom::character::complete::{char, digit1};
use nom::combinator::map_res;
use nom::multi::separated_list1;
use nom::IResult;

use crate::days::Day;

pub struct Day02;

impl Day for Day02 {
    type Input = Vec<Vec<u8>>;

    fn parse(input: &str) -> IResult<&str, Self::Input> {
        let mut result: Self::Input = vec![];
        for ele in input.split("\n") {
            let (_, r) = parse_line(ele)?;
            result.push(r);
        }

        Ok((input, result))
    }

    type Output1 = String;

    fn part_1(input: &Self::Input) -> Self::Output1 {
        input
            .into_iter()
            .filter(|x| is_save(x))
            .collect::<Vec<&Vec<u8>>>()
            .len()
            .to_string()
    }

    type Output2 = String;

    fn part_2(input: &Self::Input) -> Self::Output2 {
        let valid = input
            .into_iter()
            .filter(|x| is_save(x))
            .collect::<Vec<&Vec<u8>>>();

        let invalid = input
            .into_iter()
            .filter(|x| !is_save(x))
            .collect::<Vec<&Vec<u8>>>();

        let mut newly_valid = 0;
        for i in &invalid {
            let versions = get_row_versions(i);

            for j in versions {
                if is_save(&j) {
                    newly_valid += 1;
                    break;
                }
            }
        }

        (valid.len() + newly_valid).to_string()
    }
}

fn get_row_versions(row: &Vec<u8>) -> Vec<Vec<u8>> {
    let mut result: Vec<Vec<u8>> = vec![];

    for i in 0..row.len() {
        let mut tmp = row.clone();
        tmp.remove(i);
        result.push(tmp);
    }

    result
}

fn is_save(row: &Vec<u8>) -> bool {
    if is_decreasing(row) || is_increasing(row) {
        let mut tmp = true;

        for i in 0..row.len() - 1 {
            let diff = row[i].abs_diff(row[i + 1]);

            tmp = tmp && diff <= 3 && diff >= 1;
        }

        return tmp;
    } else {
        return false;
    }
}

fn is_decreasing(row: &Vec<u8>) -> bool {
    for i in 0..row.len() - 1 {
        if row[i] > row[i + 1] {
            return false;
        }
    }

    true
}

fn is_increasing(row: &Vec<u8>) -> bool {
    for i in 0..row.len() - 1 {
        if row[i] < row[i + 1] {
            return false;
        }
    }

    true
}

fn parse_line(input: &str) -> IResult<&str, Vec<u8>> {
    separated_list1(char(' '), map_res(digit1, |x: &str| x.parse::<u8>()))(input)
}

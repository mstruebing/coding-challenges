use itertools::Itertools;
use nom::{
    character::complete::{digit1, line_ending},
    combinator::map,
    multi::separated_list1,
    IResult,
};

use crate::days::Day;

pub struct Day03;

type Bank = Vec<u8>;

impl Day for Day03 {
    type Input = Vec<Bank>;

    fn parse(input: &str) -> IResult<&str, Self::Input> {
        separated_list1(line_ending, parse_line)(input)
    }

    type Output1 = String;

    fn part_1(input: &Self::Input) -> Self::Output1 {
        let joltages: Vec<u64> = input
            .iter()
            .map(|bank| get_highest_joltage(bank, 2))
            .collect();
        let sum: u64 = joltages
            .iter()
            .fold(0, |acc, curr| acc as u64 + *curr as u64);
        sum.to_string()
    }

    type Output2 = String;

    fn part_2(input: &Self::Input) -> Self::Output2 {
        let joltages: Vec<u64> = input
            .iter()
            .map(|bank| get_highest_joltage(bank, 12))
            .collect();
        let sum: u64 = joltages
            .iter()
            .fold(0, |acc, curr| acc as u64 + *curr as u64);
        sum.to_string()
    }
}

fn get_highest_joltage(bank: &Bank, digits: usize) -> u64 {
    let mut result = Vec::with_capacity(digits);
    let mut start = 0;

    for i in 0..digits {
        let remaining = digits - i;
        let end = bank.len() - remaining + 1;
        let &max_digit = bank[start..end].iter().max().unwrap();
        let (idx, _) = bank[start..end]
            .iter()
            .find_position(|x| **x == max_digit)
            .unwrap();
        result.push(max_digit);
        start += idx as usize + 1;
    }
    let num_str: String = result.iter().map(|d| d.to_string()).collect();
    num_str.parse::<u64>().unwrap()
}

fn parse_line(line: &str) -> IResult<&str, Vec<u8>> {
    map(digit1, |digits: &str| {
        digits
            .chars()
            .map(|c| c.to_digit(10).unwrap() as u8)
            .collect()
    })(line)
}

mod tests {
    #[allow(unused_imports)]
    use super::*;

    #[test]
    fn test_get_highest_joltage() {
        assert_eq!(
            get_highest_joltage(&vec![9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1], 2),
            98
        );

        assert_eq!(
            get_highest_joltage(&vec![8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9], 2),
            89
        );

        assert_eq!(
            get_highest_joltage(&vec![2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8], 2),
            78
        );

        assert_eq!(
            get_highest_joltage(&vec![8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1], 2),
            92
        );
    }

    #[test]
    fn test_get_highest_joltage2() {
        assert_eq!(
            get_highest_joltage(&vec![9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1], 12),
            987654321111
        );

        assert_eq!(
            get_highest_joltage(&vec![8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9], 12),
            811111111119
        );

        assert_eq!(
            get_highest_joltage(&vec![2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8], 12),
            434234234278
        );

        assert_eq!(
            get_highest_joltage(&vec![8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1], 12),
            888911112111
        );
    }
}

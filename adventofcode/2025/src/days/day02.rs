use std::ops::Rem;

use nom::{bytes::complete::tag, multi::separated_list1, IResult};

use crate::days::Day;

pub struct Day02;

type Id = u64;

impl Day for Day02 {
    type Input = Vec<(Id, Id)>;

    fn parse(input: &str) -> IResult<&str, Self::Input> {
        separated_list1(tag(","), range_parser)(input)
    }

    type Output1 = String;

    fn part_1(input: &Self::Input) -> Self::Output1 {
        let invalids: Vec<Vec<Id>> = input
            .iter()
            .map(|(first, last)| get_invalid_ids(first, last, is_invalid))
            .collect();

        let res = invalids
            .iter()
            .fold(0u64, |acc, curr| acc + curr.iter().sum::<u64>());
        res.to_string()
    }

    type Output2 = String;

    fn part_2(input: &Self::Input) -> Self::Output2 {
        let invalids: Vec<Vec<Id>> = input
            .iter()
            .map(|(first, last)| get_invalid_ids(first, last, is_invalid_2))
            .collect();

        let res = invalids
            .iter()
            .fold(0u64, |acc, curr| acc + curr.iter().sum::<u64>());
        res.to_string()
    }
}

fn range_parser(input: &str) -> IResult<&str, (Id, Id)> {
    nom::sequence::separated_pair(
        nom::character::complete::u64,
        tag("-"),
        nom::character::complete::u64,
    )(input)
}

fn is_invalid(id: Id) -> bool {
    let as_string = id.to_string();
    if as_string.len().rem(2) != 0 {
        false
    } else {
        let (first, last) = as_string.split_at(as_string.len() / 2);
        first == last
    }
}

fn is_invalid_2(id: Id) -> bool {
    let as_string = id.to_string();
    let half = as_string.len() / 2;

    for i in 1..half + 1 {
        let mut chunks = as_string
            .chars()
            .collect::<Vec<char>>()
            .chunks(i)
            .map(|c| c.iter().collect::<String>())
            .collect::<Vec<String>>();

        chunks.dedup();

        if chunks.len() == 1 {
            return true;
        }
    }

    false
}

fn get_invalid_ids<F>(start: &Id, end: &Id, is_invalid: F) -> Vec<Id>
where
    F: Fn(Id) -> bool,
{
    let mut invalid_ids: Vec<Id> = vec![];

    for id in *start..end + 1 {
        if is_invalid(id) {
            invalid_ids.push(id);
        }
    }

    invalid_ids
}

mod tests {
    #[allow(unused_imports)]
    use super::*;

    #[test]
    fn test_is_invalid() {
        assert_eq!(is_invalid(11), true);
        assert_eq!(is_invalid(22), true);
        assert_eq!(is_invalid(1010), true);
        assert_eq!(is_invalid(1188511885), true);
        assert_eq!(is_invalid(222222), true);
        assert_eq!(is_invalid(446446), true);
        assert_eq!(is_invalid(38593859), true);
        assert_eq!(is_invalid(1234), false);
    }

    #[test]
    fn test_is_invalid_2() {
        assert_eq!(is_invalid(11), true);
        assert_eq!(is_invalid(22), true);
        assert_eq!(is_invalid(1010), true);
        assert_eq!(is_invalid(1188511885), true);
        assert_eq!(is_invalid(222222), true);
        assert_eq!(is_invalid(446446), true);
        assert_eq!(is_invalid(38593859), true);
        assert_eq!(is_invalid(1234), false);

        assert_eq!(is_invalid_2(999), true);
        assert_eq!(is_invalid_2(565656), true);
        assert_eq!(is_invalid_2(824824824), true);
        assert_eq!(is_invalid_2(2121212121), true);
    }

    #[test]
    fn test_get_invalid_ids() {
        assert_eq!(get_invalid_ids(&11, &22, is_invalid), [11, 22]);
        assert_eq!(get_invalid_ids(&95, &115, is_invalid), [99]);
    }
}

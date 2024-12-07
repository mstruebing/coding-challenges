use nom::bytes::complete::tag;
use nom::character::complete::{anychar, char, digit1};
use nom::multi::{many0, many_till};
use nom::{IResult, Parser};

use crate::days::Day;

pub struct Day03;

impl Day for Day03 {
    type Input = Vec<(i32, i32)>;

    fn parse(input: &str) -> IResult<&str, Self::Input> {
        parse(input)
    }

    type Output1 = String;

    fn part_1(input: &Self::Input) -> Self::Output1 {
        input
            .into_iter()
            .fold(0, |acc, (a, b)| acc + (*a * b))
            .to_string()
    }

    type Output2 = String;

    fn part_2(_input: &Self::Input) -> Self::Output2 {
        unimplemented!("part_2")
    }
}

fn parse(input: &str) -> IResult<&str, Vec<(i32, i32)>> {
    many0(many_till(anychar, pair_parser).map(|r| r.1))(input)
}

fn pair_parser(input: &str) -> IResult<&str, (i32, i32)> {
    let (leftover, (a, b)) = nom::sequence::separated_pair(
        nom::sequence::preceded(tag("mul("), digit1),
        tag(","),
        nom::sequence::terminated(digit1, char(')')),
    )(input)?;

    Ok((leftover, (a.parse().unwrap(), b.parse().unwrap())))
}

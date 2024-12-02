use nom::{
    character::complete::{digit1, multispace1},
    IResult,
};
use std::iter::zip;

use crate::days::Day;

pub struct Day01;

impl Day for Day01 {
    type Input = (Vec<i32>, Vec<i32>);

    fn parse(input: &str) -> IResult<&str, Self::Input> {
        let mut first: Vec<i32> = vec![];
        let mut second: Vec<i32> = vec![];

        for ele in input.split("\n") {
            let (_, (f, s)) = parse_line(ele)?;
            first.push(f);
            second.push(s);
        }

        first.sort();
        second.sort();
        Ok((input, (first, second)))
    }

    type Output1 = String;

    fn part_1(input: &Self::Input) -> Self::Output1 {
        let (first, second) = input;

        let abc = zip(first.iter(), second.iter())
            .map(|(f, s)| (f - s).abs())
            .collect::<Vec<i32>>();

        let def: i32 = abc.iter().sum();

        def.to_string()
    }

    type Output2 = String;

    fn part_2(input: &Self::Input) -> Self::Output2 {
        let (first, second) = input;
        let def: Vec<i32> = first
            .iter()
            .map(|f| {
                let mut tmp = 0;

                for s in second.iter() {
                    if f == s {
                        tmp = tmp + 1;
                    }
                }

                return f * tmp;
            })
            .collect();

        def.iter().sum::<i32>().to_string()
    }
}

fn parse_line(input: &str) -> IResult<&str, (i32, i32)> {
    let (leftover, first) = digit1(input)?;
    let (leftover, _) = multispace1(leftover)?;
    let (_, second) = digit1(leftover)?;

    Ok((input, (first.parse().unwrap(), second.parse().unwrap())))
}

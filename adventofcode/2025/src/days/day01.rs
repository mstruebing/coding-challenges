use nom::{character::complete::line_ending, multi::separated_list1, sequence::tuple, IResult};

use crate::days::Day;

pub struct Day01;

// negative numbers are left movements, positive ones are right movements
type Move = i16;

impl Day for Day01 {
    type Input = Vec<Move>;

    fn parse(input: &str) -> IResult<&str, Self::Input> {
        separated_list1(line_ending, parse_line)(input)
    }

    type Output1 = String;

    fn part_1(input: &Self::Input) -> Self::Output1 {
        let mut zeros = 0;
        let mut pos = 50;

        input.into_iter().for_each(|m| {
            pos = (pos + m).rem_euclid(100);

            if pos == 0 {
                zeros += 1;
            }
        });

        zeros.to_string()
    }

    type Output2 = String;

    fn part_2(input: &Self::Input) -> Self::Output2 {
        let mut zeros = 0;
        let mut pos = 50;

        input.into_iter().for_each(|&m| {
            let start = pos;
            let end = (pos + m).rem_euclid(100);

            let mut passes = 0;
            if m > 0 {
                passes = ((start + m) / 100) - (start / 100);
            } else if m < 0 {
                // Some weird hack to get negative (left) passings
                // Couldn't  come up with something simpler, but I sure there is
                let mut s = start;
                for _ in 0..m.abs() {
                    s = (s - 1).rem_euclid(100);
                    if s == 0 {
                        passes += 1;
                    }
                }
            }

            zeros += passes;

            if end == 0 && (m == 0 || passes == 0) {
                zeros += 1;
            }

            pos = end;
        });

        zeros.to_string()
    }
}

fn parse_line(line: &str) -> IResult<&str, Move> {
    let (rest, (dir_char, dist_str)) = tuple((
        nom::character::complete::one_of("LR"),
        nom::character::complete::digit1,
    ))(line)?;

    let distance = dist_str.parse::<i16>().map_err(|_| {
        nom::Err::Error(nom::error::Error::new(
            dist_str,
            nom::error::ErrorKind::Digit,
        ))
    })?;

    let value = match dir_char {
        'L' => -distance,
        'R' => distance,
        _ => unreachable!(),
    };

    Ok((rest, value))
}

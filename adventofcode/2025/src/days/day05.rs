use nom::{
    branch::alt,
    bytes::complete::tag,
    character::complete::{digit1, line_ending},
    combinator::map_res,
    multi::separated_list1,
    sequence::separated_pair,
    IResult,
};

use crate::days::Day;

pub struct Day05;

type Range = (u64, u64);
type Id = u64;

impl Day for Day05 {
    type Input = (Vec<Range>, Vec<Id>);

    fn parse(input: &str) -> IResult<&str, Self::Input> {
        let range = map_res(
            separated_pair(digit1, tag("-"), digit1),
            |(a, b): (&str, &str)| -> Result<Range, std::num::ParseIntError> {
                Ok((a.parse()?, b.parse()?))
            },
        );

        let id = map_res(digit1, |s: &str| s.parse::<Id>());

        let (rest, (ranges, ids)) = separated_pair(
            separated_list1(line_ending, range),
            alt((tag("\n\n"), tag("\r\n\r\n"))),
            separated_list1(line_ending, id),
        )(input)?;

        Ok((rest, (ranges, ids)))
    }
    type Output1 = usize;

    fn part_1((ranges, ids): &Self::Input) -> Self::Output1 {
        let mut fresh: Self::Output1 = 0;

        for id in ids {
            for (lower_boundary, upper_boundary) in ranges {
                if id >= lower_boundary && id <= upper_boundary {
                    fresh += 1;
                    break;
                }
            }
        }

        fresh
    }

    type Output2 = u64;

    fn part_2((ranges, _): &Self::Input) -> Self::Output2 {
        let mut res: u64 = 0;
        let merged = merge_ranges(ranges);

        for (lower, upper) in merged {
            res += upper - lower + 1;
        }

        res
    }
}

fn merge_ranges(ranges: &Vec<Range>) -> Vec<Range> {
    let mut merged_ranges: Vec<Range> = ranges.clone();

    for range in ranges {
        let overlapping_ranges: Vec<Range> = find_overlapping_ranges(range, &merged_ranges);

        if overlapping_ranges.len() == 0 {
            merged_ranges.push(range.clone());
            continue;
        }

        for r in overlapping_ranges.clone() {
            merged_ranges.retain(|m| *m != r);
        }

        let lowest = overlapping_ranges
            .clone()
            .iter()
            .fold(range.0, |acc, (l, _)| if acc < *l { acc } else { *l });

        let highest = overlapping_ranges
            .clone()
            .iter()
            .fold(range.1, |acc, (_, u)| if acc > *u { acc } else { *u });

        merged_ranges.push((lowest, highest))
    }

    merged_ranges
}

fn find_overlapping_ranges(range: &Range, ranges: &Vec<Range>) -> Vec<Range> {
    let (lower, upper) = range;

    ranges
        .clone()
        .into_iter()
        .filter(|(l, u)| {
            (l >= lower && l <= upper) || (u <= upper && u >= lower) || (lower >= l && upper <= u)
        })
        .collect()
}

mod tests {
    #[allow(unused_imports)]
    use super::*;

    #[test]
    fn test_find_overlapping_ranges() {
        let ranges: Vec<Range> = vec![(3, 5), (10, 14), (16, 20), (12, 18)];

        assert_eq!(find_overlapping_ranges(&(3, 5), &ranges), vec![(3, 5)]);
        assert_eq!(
            find_overlapping_ranges(&(10, 14), &ranges),
            vec![(10, 14), (12, 18)]
        );
        assert_eq!(
            find_overlapping_ranges(&(16, 20), &ranges),
            vec![(16, 20), (12, 18)]
        );

        assert_eq!(
            find_overlapping_ranges(&(12, 18), &ranges),
            vec![(10, 14), (16, 20), (12, 18)]
        );

        assert_eq!(
            find_overlapping_ranges(&(12, 18), &vec![(3, 5), (10, 20)]),
            vec![(10, 20)]
        );
    }

    #[test]
    fn test_merge_ranges() {
        let ranges: Vec<Range> = vec![(3, 5), (10, 14), (16, 20), (12, 18)];
        assert_eq!(merge_ranges(&ranges), vec![(3, 5), (10, 20)]);
    }
}

use std::collections::HashSet;

use nom::IResult;

use crate::days::Day;

pub struct Day04;

// ..@..@@
// @.@.@.@
//
// @ roll of paper
// < 4 in adjacent places

type Coordinate = i32;
type Coordinates = (Coordinate, Coordinate);

impl Day for Day04 {
    type Input = HashSet<Coordinates>;

    fn parse(input: &str) -> IResult<&str, Self::Input> {
        let mut set = HashSet::new();
        for (row, line) in input.lines().enumerate() {
            for (col, c) in line.chars().enumerate() {
                if c == '@' {
                    set.insert((row as Coordinate, col as Coordinate));
                }
            }
        }

        Ok(("", set))
    }

    type Output1 = u32;

    fn part_1(input: &Self::Input) -> Self::Output1 {
        let mut accessible: Self::Output1 = 0;

        input.iter().for_each(|curr| {
            let adjacent_coords = get_adjacent_coords(*curr);

            let adjacent_rolls = adjacent_coords
                .into_iter()
                .filter(|x| input.contains(x))
                .collect::<Vec<Coordinates>>()
                .len();

            if adjacent_rolls < 4 {
                accessible += 1;
            }
        });

        accessible
    }

    type Output2 = usize;

    fn part_2(input: &Self::Input) -> Self::Output2 {
        let mut copy = input.clone();
        let mut old_len = input.len();
        let mut new_len = 0;

        while old_len != new_len {
            old_len = copy.len();
            copy = remove_rolls(copy);
            new_len = copy.len();
        }

        input.len() - new_len
    }
}

fn remove_rolls(input: HashSet<Coordinates>) -> HashSet<Coordinates> {
    let mut copy = input.clone();

    copy.clone().iter().for_each(|curr| {
        let adjacent_coords = get_adjacent_coords(*curr);

        let adjacent_rolls = adjacent_coords
            .into_iter()
            .filter(|x| input.contains(x))
            .collect::<Vec<Coordinates>>()
            .len();

        if adjacent_rolls < 4 {
            copy.remove(curr);
        }
    });

    copy
}

fn get_adjacent_coords(coordinates: Coordinates) -> Vec<Coordinates> {
    let (x, y) = coordinates.clone();

    vec![
        (x - 1, y),
        (x + 1, y),
        (x, y - 1),
        (x, y + 1),
        (x - 1, y - 1),
        (x + 1, y + 1),
        (x - 1, y + 1),
        (x + 1, y - 1),
    ]
}

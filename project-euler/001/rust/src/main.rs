fn main() {
    let multiples = get_all_multiples(1000, vec![3, 5]);
    let sum = sum_vector(multiples);
    println!("sum: {:?}", sum);
}

fn get_all_multiples(upper_bound: u32, dividers: Vec<u32>) -> Vec<u32> {
    let mut multiples: Vec<u32> = Vec::new();
    for num in 1..upper_bound {
        for divider in dividers.iter() {
            if num % divider == 0 && !multiples.contains(&num) {
                multiples.push(num);
            }
        }
    }

    multiples
}

fn sum_vector(numbers: Vec<u32>) -> u32 {
    numbers.into_iter().fold(0, |acc, x| acc + x)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_get_all_multiples() {
        let upper_bound = 10;
        let dividers = vec![3, 5];
        let result = vec![3, 5, 6, 9];

        assert_eq!(get_all_multiples(upper_bound, dividers), result);
    }

    #[test]
    fn test_sum_vector() {
        let input = vec![3, 5, 6, 9];
        let result = 23;

        assert_eq!(sum_vector(input), result);
    }
}

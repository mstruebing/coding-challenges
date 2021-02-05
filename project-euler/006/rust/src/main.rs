fn main() {
    println!("difference(100): {:?}", difference(100));
}

fn difference(n: u128) -> u128 {
    square_of_sum(n) - sum_of_squares(n)
}

fn sum_of_squares(n: u128) -> u128 {
    let mut sum = 0;
    for i in 1..n + 1 {
        sum += i.pow(2);
    }

    sum
}

fn square_of_sum(n: u128) -> u128 {
    let mut sum = 0;

    for i in 1..n + 1 {
        sum += i;
    }

    sum.pow(2)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sum_of_suqares() {
        assert_eq!(sum_of_squares(10), 385)
    }

    #[test]
    fn test_square_of_sum() {
        assert_eq!(square_of_sum(10), 3025)
    }

    #[test]
    fn test_difference() {
        assert_eq!(difference(10), 2640)
    }
}

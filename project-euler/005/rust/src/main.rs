fn main() {
    let res = evenly_dividable_until(20);
    println!("res: {:?}", res);
}

fn evenly_dividable_until(n: u32) -> u32 {
    let mut count = n;

    loop {
        let mut is_divisible = true;

        for i in 1..n {
            is_divisible = is_divisible && count % i == 0;
        }

        if is_divisible {
            break;
        }

        count += 1;
    }

    count
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_evenly_dividable_until() {
        assert_eq!(evenly_dividable_until(10), 2520)
    }
}

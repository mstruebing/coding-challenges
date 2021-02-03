fn main() {
    let upper_bound = 4000000;

    let result = generate_fibs(upper_bound)
        .into_iter()
        .filter(|x| x % 2 == 0)
        .fold(0, |acc, x| acc + x);

    println!("result: {:?}", result);
}

fn generate_fibs(upper_bound: usize) -> Vec<usize> {
    let mut x = vec![1, 1];
    for i in 2..upper_bound {
        let next_x = x[i - 1] + x[i - 2];

        if next_x >= upper_bound {
            break;
        }

        x.push(next_x)
    }

    x.drain(0..1);
    x
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_generate_fibs() {
        let upper_bound = 10;
        let result = vec![1, 2, 3, 5, 8];

        assert_eq!(generate_fibs(upper_bound), result)
    }
}

fn main() {
    let mut biggest_num = 0;

    for i in 0..999 {
        for j in 0..999 {
            let res = (999 - i) * (999 - j);
            if is_palindromic_number(res) && res > biggest_num {
                biggest_num = res;
            }
        }
    }

    println!("biggest_num: {:?}", biggest_num);
}

fn is_palindromic_number(number: u32) -> bool {
    let number_as_string = number.to_string();
    number_as_string == number_as_string.chars().rev().collect::<String>()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_is_palindromic_number() {
        assert_eq!(is_palindromic_number(9009), true);
        assert_eq!(is_palindromic_number(906609), true);
        assert_eq!(is_palindromic_number(9008), false);
    }
}

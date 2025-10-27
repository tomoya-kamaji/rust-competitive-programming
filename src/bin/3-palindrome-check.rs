use proconio::input;

// 回文判定関数
fn is_palindrome(s: &str) -> bool {
    let chars: Vec<char> = s.chars().collect();
    let n = chars.len();
    
    for i in 0..n / 2 {
        if chars[i] != chars[n - 1 - i] {
            return false;
        }
    }
    true
}

fn solve(s: &str) -> bool {
    is_palindrome(s)
}

fn main() {
    input! {
        s: String,
    }

    if solve(&s) {
        println!("Yes");
    } else {
        println!("No");
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_example1() {
        assert_eq!(solve("abcba"), true);
    }

    #[test]
    fn test_example2() {
        assert_eq!(solve("hello"), false);
    }

    #[test]
    fn test_single_char() {
        assert_eq!(solve("a"), true);
    }

    #[test]
    fn test_even_length() {
        assert_eq!(solve("abba"), true);
        assert_eq!(solve("abcd"), false);
    }

    #[test]
    fn test_random_strings() {
        assert_eq!(solve("racecar"), true);
        assert_eq!(solve("level"), true);
        assert_eq!(solve("algorithm"), false);
    }
}

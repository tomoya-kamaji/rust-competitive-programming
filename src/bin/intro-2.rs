use proconio::input;

// 素数判定関数
fn is_prime(n: u64) -> bool {
    if n < 2 {
        return false;
    }
    if n == 2 {
        return true;
    }
    if n % 2 == 0 {
        return false;
    }
    
    let mut i = 3;
    while i * i <= n {
        if n % i == 0 {
            return false;
        }
        i += 2;
    }
    true
}

fn solve(n: u64) -> bool {
    is_prime(n)
}

fn main() {
    input! {
        n: u64,
    }

    if solve(n) {
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
        assert_eq!(solve(17), true);
    }

    #[test]
    fn test_example2() {
        assert_eq!(solve(10), false);
    }

    #[test]
    fn test_small_primes() {
        assert_eq!(solve(2), true);
        assert_eq!(solve(3), true);
        assert_eq!(solve(5), true);
        assert_eq!(solve(7), true);
    }

    #[test]
    fn test_non_primes() {
        assert_eq!(solve(4), false);
        assert_eq!(solve(6), false);
        assert_eq!(solve(9), false);
        assert_eq!(solve(15), false);
    }
}

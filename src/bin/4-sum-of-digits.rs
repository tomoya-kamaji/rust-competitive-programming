use proconio::input;

// 解法を実装する関数
fn solve(n: usize) -> usize {
    let mut sum: usize = 0;
    let mut current = n;
    while current > 0 {
        sum += current % 10;
        current /= 10;
    }
    sum
}

fn solve2(n: usize) -> usize {
    n.to_string()
        .chars()
        .map(|c| c.to_digit(10).unwrap())
        .sum::<u32>() as usize
}

// イテレータを使う
fn solve3(n: usize) -> usize {
    let mut num = n;
    std::iter::from_fn(move || {
        if num > 0 {
            let digit = num % 10;
            num /= 10;
            Some(digit)
        } else {
            None
        }
    })
    .sum()
}

fn main() {
    input! {
        n: usize,
    }

    let result = solve(n);
    solve2(n);
    solve3(n);
    println!("{}", result);
}

// テストケース
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_example1() {
        // 1234 -> 10
        let n = 1234;
        let result = solve(n);
        assert_eq!(result, 10);
    }

    #[test]
    fn test_example2() {
        let n = 98765;
        let result = solve2(n);
        assert_eq!(result, 35);
    }

    #[test]
    fn test_example3() {
        let n = 98765;
        let result = solve3(n);
        assert_eq!(result, 35);
    }
}

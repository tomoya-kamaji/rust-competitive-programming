use proconio::input;

// 解法を実装する関数
fn solve(n: usize) -> usize {
    // ここに解法を記述
    n
}

fn main() {
    input! {
        n: usize,
    }

    let result = solve(n);
    println!("{}", result);
}

// テストケース
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_example1() {
        assert_eq!(solve(5), 5);
    }

    #[test]
    fn test_example2() {
        assert_eq!(solve(10), 10);
    }
}

use proconio::input;

// 最大値、最小値、合計を返す
fn solve(a: &[i64]) -> (i64, i64, i64) {
    let max_val = *a.iter().max().unwrap();
    let min_val = *a.iter().min().unwrap();
    let sum_val: i64 = a.iter().sum();
    (max_val, min_val, sum_val)
}

fn main() {
    input! {
        n: usize,
        a: [i64; n],
    }

    let (max_val, min_val, sum_val) = solve(&a);
    println!("max: {}", max_val);
    println!("min: {}", min_val);
    println!("sum: {}", sum_val);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_example1() {
        let a = vec![1, 2, 3, 4, 5];
        let (max, min, sum) = solve(&a);
        assert_eq!(max, 5);
        assert_eq!(min, 1);
        assert_eq!(sum, 15);
    }

    #[test]
    fn test_example2() {
        let a = vec![-10, 0, 10];
        let (max, min, sum) = solve(&a);
        assert_eq!(max, 10);
        assert_eq!(min, -10);
        assert_eq!(sum, 0);
    }

    #[test]
    fn test_example3() {
        let a = vec![5];
        let (max, min, sum) = solve(&a);
        assert_eq!(max, 5);
        assert_eq!(min, 5);
        assert_eq!(sum, 5);
    }
}

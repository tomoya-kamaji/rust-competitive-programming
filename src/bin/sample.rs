use proconio::input;
use std::collections::*;

fn main() {
    input! {
        // ここに入力を記述
        n: usize,
    }
    
    // ここに解法を記述
    
    println!("{}", n);
}

// よく使う関数やマクロをここに記述
fn gcd(a: i64, b: i64) -> i64 {
    if b == 0 { a } else { gcd(b, a % b) }
}

fn lcm(a: i64, b: i64) -> i64 {
    a / gcd(a, b) * b
}

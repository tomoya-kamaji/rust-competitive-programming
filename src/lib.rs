// 競技プログラミング用のユーティリティライブラリ

pub mod utils {

    // よく使う型のエイリアス
    pub type Graph = Vec<Vec<usize>>;
    pub type WeightedGraph<T> = Vec<Vec<(usize, T)>>;

    // 最大公約数
    pub fn gcd(a: i64, b: i64) -> i64 {
        if b == 0 {
            a
        } else {
            gcd(b, a % b)
        }
    }

    // 最小公倍数
    pub fn lcm(a: i64, b: i64) -> i64 {
        a / gcd(a, b) * b
    }

    // 素数判定
    pub fn is_prime(n: u64) -> bool {
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

    // 素因数分解
    pub fn prime_factors(mut n: u64) -> Vec<(u64, usize)> {
        let mut factors = Vec::new();

        // 2で割り切れる回数
        let mut count = 0;
        while n % 2 == 0 {
            n /= 2;
            count += 1;
        }
        if count > 0 {
            factors.push((2, count));
        }

        // 3以上の奇数で割り切れる回数
        let mut i = 3;
        while i * i <= n {
            let mut count = 0;
            while n % i == 0 {
                n /= i;
                count += 1;
            }
            if count > 0 {
                factors.push((i, count));
            }
            i += 2;
        }

        if n > 1 {
            factors.push((n, 1));
        }

        factors
    }

    // 順列・組み合わせ
    pub struct Combinatorics {
        fact: Vec<i64>,
        inv_fact: Vec<i64>,
        modulo: i64,
    }

    impl Combinatorics {
        pub fn new(n: usize, modulo: i64) -> Self {
            let mut fact = vec![1; n + 1];
            let mut inv_fact = vec![1; n + 1];

            for i in 1..=n {
                fact[i] = fact[i - 1] * i as i64 % modulo;
            }

            inv_fact[n] = mod_pow(fact[n], modulo - 2, modulo);
            for i in (1..n).rev() {
                inv_fact[i] = inv_fact[i + 1] * (i + 1) as i64 % modulo;
            }

            Self {
                fact,
                inv_fact,
                modulo,
            }
        }

        pub fn permutation(&self, n: usize, r: usize) -> i64 {
            if n < r {
                return 0;
            }
            self.fact[n] * self.inv_fact[n - r] % self.modulo
        }

        pub fn combination(&self, n: usize, r: usize) -> i64 {
            if n < r {
                return 0;
            }
            self.fact[n] * self.inv_fact[r] % self.modulo * self.inv_fact[n - r] % self.modulo
        }
    }

    // 累乗 (mod付き)
    pub fn mod_pow(mut base: i64, mut exp: i64, modulo: i64) -> i64 {
        let mut result = 1;
        while exp > 0 {
            if exp % 2 == 1 {
                result = result * base % modulo;
            }
            base = base * base % modulo;
            exp /= 2;
        }
        result
    }

    // Union-Find
    pub struct UnionFind {
        parent: Vec<usize>,
        rank: Vec<usize>,
        size: Vec<usize>,
    }

    impl UnionFind {
        pub fn new(n: usize) -> Self {
            Self {
                parent: (0..n).collect(),
                rank: vec![0; n],
                size: vec![1; n],
            }
        }

        pub fn find(&mut self, x: usize) -> usize {
            if self.parent[x] != x {
                self.parent[x] = self.find(self.parent[x]);
            }
            self.parent[x]
        }

        pub fn union(&mut self, x: usize, y: usize) -> bool {
            let root_x = self.find(x);
            let root_y = self.find(y);

            if root_x == root_y {
                return false;
            }

            if self.rank[root_x] < self.rank[root_y] {
                self.parent[root_x] = root_y;
                self.size[root_y] += self.size[root_x];
            } else if self.rank[root_x] > self.rank[root_y] {
                self.parent[root_y] = root_x;
                self.size[root_x] += self.size[root_y];
            } else {
                self.parent[root_y] = root_x;
                self.size[root_x] += self.size[root_y];
                self.rank[root_x] += 1;
            }

            true
        }

        pub fn connected(&mut self, x: usize, y: usize) -> bool {
            self.find(x) == self.find(y)
        }

        pub fn size(&mut self, x: usize) -> usize {
            let root = self.find(x);
            self.size[root]
        }
    }
}

// よく使うマクロ
#[macro_export]
macro_rules! min {
    ($a:expr) => { $a };
    ($a:expr, $($rest:expr),+) => { std::cmp::min($a, min!($($rest),+)) };
}

#[macro_export]
macro_rules! max {
    ($a:expr) => { $a };
    ($a:expr, $($rest:expr),+) => { std::cmp::max($a, max!($($rest),+)) };
}

#[macro_export]
macro_rules! chmin {
    ($a:expr, $b:expr) => {
        if $a > $b {
            $a = $b;
            true
        } else {
            false
        }
    };
}

#[macro_export]
macro_rules! chmax {
    ($a:expr, $b:expr) => {
        if $a < $b {
            $a = $b;
            true
        } else {
            false
        }
    };
}

#include <bits/stdc++.h>
using namespace std;

vector<vector<int>> resultList;

// 10進数の文字列を任意基数（2〜10）に変換する（大数対応）
string base_convert(const string &num_str, int base) {
    if (num_str == "0") return "0";
    string result;
    string current = num_str;

    while (current != "0") {
        int remainder = 0;
        string next_num;
        for (char c : current) {
            int digit = remainder * 10 + (c - '0');
            int q = digit / base;
            remainder = digit % base;
            if (!(next_num.empty() && q == 0)) next_num += (char)('0' + q);
        }
        result += (char)('0' + remainder);
        current = next_num.empty() ? "0" : next_num;
    }
    reverse(result.begin(), result.end());
    return result;
}

// 回文かどうか判定
bool checkPalindrome(const string &s) {
    size_t half = s.size() / 2;
    return s.substr(0, half) == string(s.rbegin(), s.rend()).substr(0, half);
}

// 大数加算（10進数文字列同士）
string add_bigints(const string& a, const string& b) {
    string res;
    int carry = 0;
    int i = (int)a.size() - 1, j = (int)b.size() - 1;

    while (i >= 0 || j >= 0 || carry) {
        int digit = carry;
        if (i >= 0) digit += a[i--] - '0';
        if (j >= 0) digit += b[j--] - '0';
        carry = digit / 10;
        res += '0' + (digit % 10);
    }
    reverse(res.begin(), res.end());
    return res;
}

// 回文数列生成
void saiki(vector<int>& left, vector<int>& right, int weight) {
    ++weight;
    for (int i = 0; i < 10; ++i) {
        if (weight == 1 && i == 0) continue;
        left.push_back(i);

        vector<int> merged = left;
        merged.insert(merged.end(), right.begin(), right.end());
        resultList.push_back(merged);

        right.insert(right.begin(), i);
        merged = left;
        merged.insert(merged.end(), right.begin(), right.end());
        resultList.push_back(merged);

        if (weight < 6) {
            saiki(left, right, weight);
        }

        right.erase(right.begin());
        left.pop_back();
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int a;
    string n_str;
    cin >> a >> n_str;

    string ans = "0";
    vector<int> left, right;
    saiki(left, right, 0);

    // 昇順ソートして途中打ち切り可能に（小さい順で処理）
    sort(resultList.begin(), resultList.end(), [](const auto& a, const auto& b) {
        if (a.size() != b.size()) return a.size() < b.size();
        return a < b;
    });

    for (const auto& digits : resultList) {
        string num_str;
        for (int d : digits) num_str += to_string(d);

        // ii > n の時スキップ
        if (num_str.size() > n_str.size() || 
            (num_str.size() == n_str.size() && num_str > n_str)) {
            continue;
        }

        string base_str = base_convert(num_str, a);
        if (checkPalindrome(base_str)) {
            ans = add_bigints(ans, num_str);
        }
    }

    cout << ans << '\n';
    return 0;
}

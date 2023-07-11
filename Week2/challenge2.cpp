#include <bits/stdc++.h>
using namespace std;
typedef int ll;
typedef pair<ll,ll> p;
typedef pair<p, ll> tri;
typedef vector<ll> v;
typedef vector<v> vv;
typedef vector<p> vp;
typedef vector<tri> vtri;
typedef vector<vv> vvv;
typedef vector<bool> vb;
typedef vector<vb> vvb;
typedef vector<vvb> vvvb;
typedef vector<p> vp;
typedef vector<vp> vvp;
typedef vector<vvp> vvvp;
typedef vector<vvvp> vvvvp;
typedef pair<ll, p> pp;
typedef vector<pp> vpp;
typedef vector<vpp> vvpp;
typedef vector<vvpp> vvvpp;
typedef vector<vvvpp> vvvvpp;

const ll mod = 1e9 + 7;
const ll INF = 1e9;

ll evaluate(vv graph)
{
    ll n = graph.size();
    vv distance(n, v(n, INF)), prev(n, v(n, -1));
    for (ll i = 0; i < n; i++)
    {
        for (ll j = 0; j < n; j++)
        {
            if (graph[i][j] != -1) {distance[i][j] = graph[i][j]; prev[i][j] = i;}
        }
    }
    for (ll k= 0 ; k < n; k++)
    {
        for (ll i = 0; i < n; i++)
        {
            for (ll j = 0; j < n; j++)
            {
                if (distance[i][j] > distance[i][k] + distance[k][j])
                {
                    distance[i][j] = distance[i][k] + distance[k][j];
                    prev[i][j] = prev[k][j];
                }
            }
        }
    }
    vv dp(pow(2, n), v(n, INF)), next(pow(2, n), v(n, -1));
    for (ll j = 0; j < n; j++) dp[0][j] = 0;
    for (ll i= 1 ; i < pow(2, n); i++)
    {
        for (ll j = 0; j < n; j++)
        {
            for (ll k = 0; k < n; k++)
            {
                if (i & (1 << k) && distance[j][k] != INF)
                {
                    ll val = dp[i ^ (1 << k)][k] + distance[j][k];
                    if (dp[i][j] > val)
                    {
                        next[i][j] = k;
                        dp[i][j] = val;
                    }
                }
            }
        }
    }
    ll mini = INF;
    ll base = pow(2, n) - 1;
    ll start = -1;
    for (ll i = 0; i < n; i++)
    {
        mini = min(mini, dp[base ^ (1 << i)][i]);
    }
    return (mini == INF)? -1 : mini;
}

int main()
{
    ios_base::sync_with_stdio(false);cin.tie(NULL);cout.tie(NULL);
    ll n;
    cin >> n;
    vv graph(n, v(n, 0));
    std::random_device rd;  // a seed source for the random number engine
    std::mt19937 gen(rd()); // mersenne_twister_engine seeded with rd()
    std::uniform_int_distribution<> distrib(-1, 10);
    for (ll i= 0 ; i < n; i++)
    {
        for (ll j = 0; j < n; j++)  
        {
            if (i == j) continue;
            graph[i][j] = distrib(gen);
            //cin >> graph[i][j];
        }
    }
    ll ans = evaluate(graph);
    for (ll i= 0 ; i < n; i++)
    {
        for (ll j = 0; j < n; j++)
        {
            cout << graph[i][j] << "\n";
        }
        //cout << "\n";
    }
    cout << "\n";
    cout << ans << "\n";
    return 0;
}
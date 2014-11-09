template<class T>
vector<T> interleave(vector<T> a, vector<T> b) {
  vector<T> result = {};
  int asize = a.size(), bsize = b.size(), maxsize = max(asize, bsize);
  for (int i = 0; i < maxsize; i++) {
    if (i < asize) result.push_back(a[i]);
    if (i < bsize) result.push_back(b[i]);
  }
  return result;
}

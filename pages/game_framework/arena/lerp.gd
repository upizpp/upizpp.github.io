# 注：lerp函数gd中已经内置，这里只是用gds的形式展现其原理。
func lerp(a: float, b: float, t: float) -> float:
    return (b - a) * t + a

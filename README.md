# Polyblock Approximation 算法
A partial reproduction of the simulation of a IEEE paper.
> Y. Wu, Y. Song, T. Wang, L. Qian, and T. Q. S. Quek, “Non-Orthogonal Multiple Access Assisted Federated Learning via Wireless Power Transfer: A Cost-Efficient Approach,” IEEE Trans. Commun., vol. 70, no. 4, pp. 2853–2869, Apr. 2022, doi: 10.1109/TCOMM.2022.3153068.
# 问题描述
原问题（SCM-E-TOP）
$$\min f(\epsilon) = \sigma^{glo}_{(\epsilon)}\hat{V}(\epsilon)$$
约束$$(59)0 \leq \epsilon \leq \epsilon^{\max}$$
在式 (59) 中引入了辅助变量auxiliary variable $z$，其定义为$z = \frac{\sigma_{glo,\max}}{\sigma_{glo}(\epsilon)}$

将原问题转化为(SCM-E-Top") 
$$ \min f(\epsilon, z) = \frac{\sigma^{glo,\max}}{z} \hat{V}_{(\epsilon)} $$
约束$$(60)0\leq z\sigma_{(\epsilon)}^{glo};\leq \sigma^{glo,\max};$$
约束（边界）$$0 \leq z \leq \sigma_{glo,\max};0 \leq \epsilon \leq \epsilon^{\max}$$

单调性文章已经证明过了，这样就来解决针对$(\epsilon,z)$ 的新问题，两个约束对应这两个变量的可行域。
利用多面体逼近算法 用一组正规集$V_k$来包含其可行域，
注意V是由顶点生成的，其实每次迭代都需要寻找新的有效顶点。
新的顶点是由投影算法来实现，通过二分法将顶点投影到约束（60）边界上，（也就是投影后的点与边界的距离小于$\hat{\epsilon }$，精度）
然后就是有效顶点的筛选；剔除无效顶点。

## 项目简介
该项目实现了 **Polyblock Approximation** 算法，用于解决在多维空间中的凸优化问题。该算法通过多边形块的逼近逐步收敛到最优解。项目包含主要算法的实现以及相应的测试用例。

## 算法介绍
Polyblock Approximation 是一种基于分块的优化算法，广泛应用于多维凸优化问题。它的核心思想是通过逐步逼近的方式来找到凸集内的最优点。该算法具有广泛的应用场景，如线性规划、非线性规划等领域。

### 算法的主要步骤
1. 初始化多面体块。
2. 通过逼近计算新块，直到满足收敛条件。
3. 返回最优解。

## 使用说明

### 依赖安装
项目基于 Matlab 实现，您可以通过以下命令安装所需依赖：
```bash
pip install -r requirements.txt

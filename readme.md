# my-blockchain

> 基于 Cosmos SDK 开发的自定义区块链项目，实现完整的区块链生态系统功能

## 🌟 功能特性

✅ **代币铸造** - 能够代币的生产  
- 铸造新代币到指定地址
- 销毁代币减少总供应量
- 查询代币总供应量
- 可配置的铸造参数和最大供应量

✅ **用户管理** - 能够新建一个用户  
- 创建用户档案（姓名、邮箱、头像等）
- 更新用户信息
- 查询用户列表和详细信息
- 用户状态管理（激活/停用）

✅ **代币转账** - 能够完成代币的转账  
- P2P 代币转账
- 批量转账功能
- 转账历史记录查询
- 转账统计和分析

✅ **挖矿系统** - 矿工功能  
- 矿工注册和管理
- 算力统计和挖矿奖励
- 挖矿难度调整
- 矿工排行榜和统计

✅ **区块链浏览器** - 有基本区块链浏览器能够查看当前的块高度的还有区块信息  
- 实时区块高度查询
- 详细区块信息展示
- 交易查询和历史记录
- 网络状态和验证者信息
- 地址余额和交易统计

## 🚀 快速开始

### 环境要求
- **Go 1.24+** - [下载安装](https://golang.org/dl/)
- **Git** - 版本控制
- **Ignite CLI** - Cosmos 区块链开发工具

### 1. 安装 Ignite CLI
```bash
curl https://get.ignite.com/cli! | bash
```

### 2. 克隆项目
```bash
git clone https://github.com/leonaries/my-blockchain.git
cd my-blockchain
```

### 3. 启动开发环境
```bash
# 启动完整开发环境
ignite chain serve

# 区块链将自动启动，并提供：
# ✅ 本地测试网络
# ✅ 预创建的测试账户 (alice, bob)
# ✅ REST API (http://localhost:1317)
# ✅ RPC 端点 (http://localhost:26657)
# ✅ 代币水龙头 (http://localhost:4500)
```

## 📁 项目结构

```
my-blockchain/
├── 📁 proto/myblockchain/     # Protocol Buffers 定义
│   ├── 🪙 token/             # 代币模块协议
│   ├── 👥 user/              # 用户模块协议  
│   ├── 💸 transfer/          # 转账模块协议
│   ├── ⛏️ mining/            # 挖矿模块协议
│   └── 🔍 explorer/          # 浏览器模块协议
├── 📁 x/                     # 自定义模块实现
│   ├── myblockchainnew/      # 基础模块
│   └── ...                   # 其他模块
├── 📁 app/                   # 应用程序核心
├── 📁 cmd/                   # CLI 命令
├── 📁 scripts/               # 部署脚本
├── 📁 docs/                  # 项目文档
├── 🐳 Dockerfile            # Docker 配置
├── 📦 docker-compose.yml    # Docker Compose
├── ⚙️ config.yml            # Ignite 配置
├── 🔧 Makefile              # 构建工具
└── 📖 README.md             # 项目说明
```

---

⭐ **Built with ❤️ using [Cosmos SDK](https://cosmos.network) and [Ignite CLI](https://ignite.com)**

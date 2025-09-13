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
- **Go 1.21+** - [下载安装](https://golang.org/dl/)
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

### 3. 启动开发环境 (推荐)
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

### 4. 或者手动部署
```bash
# 运行部署脚本
chmod +x scripts/deploy.sh
./scripts/deploy.sh

# 启动区块链
./my-blockchaind start
```

## 🛠️ 使用指南

### 代币操作 🪙

```bash
# 查询账户余额
my-blockchaind query bank balances $(my-blockchaind keys show alice -a --keyring-backend test)

# 铸造代币 (需要权限)
my-blockchaind tx token mint-tokens 1000000token myblockchain1... --from alice --chain-id mychain-1 -y

# 查询代币总供应量
my-blockchaind query token total-supply token

# 销毁代币
my-blockchaind tx token burn-tokens 10000token --from alice --chain-id mychain-1 -y
```

### 用户管理 👥

```bash
# 创建用户档案
my-blockchaind tx user create-user "Alice Smith" "alice@example.com" "Blockchain enthusiast" "https://avatar.url" --from alice --chain-id mychain-1 -y

# 查询用户信息
my-blockchaind query user user $(my-blockchaind keys show alice -a --keyring-backend test)

# 查询所有用户
my-blockchaind query user list-users

# 更新用户信息
my-blockchaind tx user update-user "Alice Cooper" "alice.cooper@example.com" --from alice --chain-id mychain-1 -y

# 检查用户是否存在
my-blockchaind query user user-exists $(my-blockchaind keys show alice -a --keyring-backend test)
```

### 代币转账 💸

```bash
# 创建第二个账户
my-blockchaind keys add bob --keyring-backend test

# P2P 转账
my-blockchaind tx transfer send-tokens $(my-blockchaind keys show bob -a --keyring-backend test) 1000token "Transfer memo" --from alice --chain-id mychain-1 -y

# 批量转账
my-blockchaind tx transfer batch-send '[{"to_address":"...","amount":"500"},{"to_address":"...","amount":"300"}]' token "Batch transfer" --from alice --chain-id mychain-1 -y

# 查询转账历史
my-blockchaind query transfer transfer-history $(my-blockchaind keys show alice -a --keyring-backend test)

# 查询转账统计
my-blockchaind query transfer transfer-stats $(my-blockchaind keys show alice -a --keyring-backend test) 30d
```

### 挖矿系统 ⛏️

```bash
# 注册为矿工
my-blockchaind tx mining register-miner "Alice Miner" 1000000 --from alice --chain-id mychain-1 -y

# 开始挖矿
my-blockchaind tx mining start-mining --from alice --chain-id mychain-1 -y

# 查询矿工信息
my-blockchaind query mining miner $(my-blockchaind keys show alice -a --keyring-backend test)

# 查询所有矿工
my-blockchaind query mining list-miners

# 查询挖矿统计
my-blockchaind query mining mining-stats

# 查询挖矿难度
my-blockchaind query mining mining-difficulty

# 查询挖矿奖励
my-blockchaind query mining mining-rewards $(my-blockchaind keys show alice -a --keyring-backend test)

# 更新算力
my-blockchaind tx mining update-hash-rate 2000000 --from alice --chain-id mychain-1 -y

# 停止挖矿
my-blockchaind tx mining stop-mining --from alice --chain-id mychain-1 -y
```

### 区块链浏览器 🔍

```bash
# 查询当前区块高度
my-blockchaind query explorer current-height

# 查询指定区块信息
my-blockchaind query explorer block-info 100

# 查询最新区块
my-blockchaind query explorer latest-blocks 10

# 查询交易信息
my-blockchaind query explorer transaction-info [tx-hash]

# 查询区块内的所有交易
my-blockchaind query explorer transactions-by-block 100

# 查询网络状态
my-blockchaind query explorer network-status

# 查询验证者集合
my-blockchaind query explorer validator-set

# 搜索地址信息
my-blockchaind query explorer search-address $(my-blockchaind keys show alice -a --keyring-backend test)
```

## 🌐 API 接口

### REST API (http://localhost:1317)

#### Token 模块
- `POST /cosmos/token/v1beta1/mint` - 铸造代币
- `POST /cosmos/token/v1beta1/burn` - 销毁代币
- `GET /cosmos/token/v1beta1/total_supply/{denom}` - 查询总供应量

#### User 模块  
- `POST /cosmos/user/v1beta1/create` - 创建用户
- `POST /cosmos/user/v1beta1/update` - 更新用户
- `GET /cosmos/user/v1beta1/user/{address}` - 查询用户
- `GET /cosmos/user/v1beta1/users` - 查询所有用户

#### Transfer 模块
- `POST /cosmos/transfer/v1beta1/send` - 发送代币
- `POST /cosmos/transfer/v1beta1/batch_send` - 批量转账
- `GET /cosmos/transfer/v1beta1/history/{address}` - 转账历史

#### Mining 模块
- `POST /cosmos/mining/v1beta1/register` - 注册矿工
- `POST /cosmos/mining/v1beta1/start` - 开始挖矿
- `GET /cosmos/mining/v1beta1/stats` - 挖矿统计

#### Explorer 模块
- `GET /cosmos/explorer/v1beta1/height` - 当前高度
- `GET /cosmos/explorer/v1beta1/block/{height}` - 区块信息
- `GET /cosmos/explorer/v1beta1/status` - 网络状态

### gRPC 接口 (localhost:9090)

使用 [grpcurl](https://github.com/fullstorydev/grpcurl) 或其他 gRPC 客户端：

```bash
# 列出所有服务
grpcurl -plaintext localhost:9090 list

# 查询区块高度
grpcurl -plaintext localhost:9090 myblockchain.explorer.Query/CurrentHeight

# 查询代币总供应量
grpcurl -plaintext -d '{"denom": "token"}' localhost:9090 myblockchain.token.Query/TotalSupply
```

## 🐳 Docker 部署

### 使用 Docker Compose (推荐)

```bash
# 启动完整环境
docker-compose up -d

# 查看日志
docker-compose logs -f my-blockchain

# 停止服务
docker-compose down

# 重建并启动
docker-compose up --build -d
```

### 使用 Docker

```bash
# 构建镜像
docker build -t my-blockchain:latest .

# 运行容器
docker run -d \
  --name my-blockchain-node \
  -p 26657:26657 \
  -p 1317:1317 \
  -p 9090:9090 \
  my-blockchain:latest
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
│   ├── token/               # 代币模块
│   ├── user/                # 用户模块
│   ├── transfer/            # 转账模块
│   ├── mining/              # 挖矿模块
│   └── explorer/            # 浏览器模块
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

## 🧪 测试

```bash
# 运行单元测试
go test ./...

# 运行带覆盖率的测试
make test-cover

# 运行竞争条件测试
make test-race

# 代码格式化
make format

# 代码检查
make lint
```

## 🔧 开发指南

### 添加新模块

```bash
# 使用 Ignite CLI 创建模块
ignite scaffold module [module-name]

# 添加消息类型
ignite scaffold message [message-name] [fields] --module [module-name]

# 添加查询类型
ignite scaffold query [query-name] [fields] --module [module-name]
```

### 自定义开发

```bash
# 生成 Protocol Buffers
make proto-gen

# 格式化 proto 文件
make proto-format

# proto 语法检查
make proto-lint
```

## 📊 监控和日志

### 查看运行状态

```bash
# 查看节点状态
my-blockchaind status

# 查看网络信息
curl -s http://localhost:26657/net_info | jq

# 查看区块链信息
curl -s http://localhost:26657/blockchain | jq

# 查看最新区块
curl -s http://localhost:26657/block | jq
```

### 日志配置

在 `~/.my-blockchain/config/config.toml` 中配置日志级别：

```toml
[log]
level = "info"
format = "plain"
```

## 🚀 生产部署

### 系统要求
- **CPU**: 4核心或更多
- **内存**: 8GB RAM
- **存储**: 500GB SSD
- **网络**: 100Mbps 带宽

### 安全配置

```bash
# 防火墙设置
sudo ufw allow 26656/tcp  # P2P
sudo ufw allow 26657/tcp  # RPC (谨慎开放)
sudo ufw enable

# 创建系统服务
sudo tee /etc/systemd/system/my-blockchain.service > /dev/null <<EOF
[Unit]
Description=My Blockchain Node
After=network.target

[Service]
Type=simple
User=blockchain
WorkingDirectory=/home/blockchain
ExecStart=/usr/local/bin/my-blockchaind start
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOF

# 启动服务
sudo systemctl enable my-blockchain
sudo systemctl start my-blockchain
```

## 🤝 贡献指南

1. **Fork** 本项目
2. 创建功能分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 打开 **Pull Request**

### 开发流程

- 遵循 [Go 编码规范](https://golang.org/doc/effective_go.html)
- 添加测试用例覆盖新功能
- 更新相关文档
- 确保所有测试通过

## 📄 许可证

本项目采用 **MIT 许可证** - 详见 [LICENSE](LICENSE) 文件

## 🔗 相关链接

- **项目地址**: https://github.com/leonaries/my-blockchain
- **Cosmos SDK**: https://github.com/cosmos/cosmos-sdk
- **Ignite CLI**: https://github.com/ignite/cli
- **问题反馈**: https://github.com/leonaries/my-blockchain/issues
- **技术文档**: https://github.com/leonaries/my-blockchain/tree/main/docs

## 📞 支持

如果你在使用过程中遇到问题：

1. 查看 [常见问题](https://github.com/leonaries/my-blockchain/wiki/FAQ)
2. 搜索现有 [Issues](https://github.com/leonaries/my-blockchain/issues)
3. 创建新的 Issue 描述问题
4. 加入我们的社区讨论

---

⭐ **如果这个项目对你有帮助，请给我们一个 Star！** ⭐

**Built with ❤️ using [Cosmos SDK](https://cosmos.network) and [Ignite CLI](https://ignite.com)**

#!/bin/bash

# my-blockchain 快速部署脚本

set -e

echo "🚀 开始部署 my-blockchain 区块链..."

# 检查依赖
if ! command -v ignite &> /dev/null; then
    echo "❌ Ignite CLI 未安装"
    echo "请运行: curl https://get.ignite.com/cli! | bash"
    exit 1
fi

if ! command -v go &> /dev/null; then
    echo "❌ Go 未安装，请安装 Go 1.21+"
    exit 1
fi

echo "✅ 依赖检查通过"

# 构建项目
echo "📦 构建项目..."
go mod tidy
ignite chain build

echo "⚙️ 初始化区块链..."
./my-blockchaind init mynode --chain-id mychain-1

echo "👤 创建测试账户..."
./my-blockchaind keys add alice --keyring-backend test
./my-blockchaind keys add bob --keyring-backend test

echo "💰 配置创世账户..."
./my-blockchaind add-genesis-account alice 100000000token --keyring-backend test
./my-blockchaind add-genesis-account bob 50000000token --keyring-backend test

echo "📝 生成创世交易..."
./my-blockchaind gentx alice 70000000token --chain-id mychain-1 --keyring-backend test

echo "🔄 收集创世交易..."
./my-blockchaind collect-gentxs

echo "✅ 验证创世文件..."
./my-blockchaind validate-genesis

echo "🎉 部署完成！"
echo ""
echo "启动区块链:"
echo "  ./my-blockchaind start"
echo ""
echo "或者使用 Ignite (推荐):"
echo "  ignite chain serve"
echo ""
echo "API 端点:"
echo "  REST API: http://localhost:1317"
echo "  RPC:      http://localhost:26657"
echo "  gRPC:     localhost:9090"
echo ""
echo "测试命令示例:"
echo "# 查询余额"
echo "./my-blockchaind query bank balances \$(./my-blockchaind keys show alice -a --keyring-backend test)"
echo ""
echo "# 创建用户"
echo "./my-blockchaind tx user create-user \"Alice\" \"alice@example.com\" --from alice --chain-id mychain-1 --keyring-backend test -y"
echo ""
echo "# 发送代币"
echo "./my-blockchaind tx transfer send-tokens \$(./my-blockchaind keys show bob -a --keyring-backend test) 1000token --from alice --chain-id mychain-1 --keyring-backend test -y"
echo ""
echo "# 注册矿工"
echo "./my-blockchaind tx mining register-miner \"Alice Miner\" 1000 --from alice --chain-id mychain-1 --keyring-backend test -y"
echo ""
echo "# 查询区块高度"
echo "./my-blockchaind query explorer current-height"

#!/bin/bash

# Update SEO Protection for All Generated HTML Files
# This script adds meta robots tags to all existing HTML files to block search engines

echo "🔒 开始更新SEO保护设置..."

# Define the meta tags to add
META_TAGS='    <!-- Block search engines but allow ad crawlers -->
    <meta name="robots" content="noindex, nofollow">
    <meta name="googlebot" content="noindex, nofollow">
'

# Counter for updated files
UPDATED_COUNT=0

# Find all HTML files in docs directory (excluding cache and temp files)
find ./docs -name "*.html" -type f | while read -r file; do
    # Check if file already has the robots meta tag
    if ! grep -q 'meta name="robots"' "$file"; then
        # Use sed to insert meta tags after the viewport meta tag
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS version
            sed -i '' '/<meta name="viewport"/a\
    \
    <!-- Block search engines but allow ad crawlers -->\
    <meta name="robots" content="noindex, nofollow">\
    <meta name="googlebot" content="noindex, nofollow">\
' "$file"
        else
            # Linux version
            sed -i '/<meta name="viewport"/a\    \n    <!-- Block search engines but allow ad crawlers -->\n    <meta name="robots" content="noindex, nofollow">\n    <meta name="googlebot" content="noindex, nofollow">\n' "$file"
        fi
        
        echo "✅ 已更新: $file"
        ((UPDATED_COUNT++))
    else
        echo "⏭️  跳过（已存在）: $file"
    fi
done

echo ""
echo "✨ SEO保护更新完成！"
echo "📊 总共更新了 $UPDATED_COUNT 个文件"
echo ""
echo "📝 提示："
echo "  1. robots.txt 已更新为阻止搜索引擎但允许广告爬虫"
echo "  2. 所有HTML文件已添加 noindex, nofollow 标签"
echo "  3. AdX广告爬虫（Mediapartners-Google, AdsBot-Google）仍可访问"
echo "  4. 记得运行 git add . && git commit && git push 来部署更改"

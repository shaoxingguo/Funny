-- 创建数据表
CREATE TABLE IF NOT EXISTS "T_Topic" (
"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
"topic" TEXT NOT NULL,
"createTime" TEXT NOT NULL DEFAULT (datetime('now', 'localtime'))
);

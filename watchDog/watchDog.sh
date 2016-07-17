#!/bin/bash
#set -x
#超过timeout时间还没执行完，则kill进程，发邮件告警:

mailSend()
{
    mailContent="xxxx Web response time over 5 seconds"
    echo $mailContent | mail -s "xxxxxx Web TimeOut" xxxxx@xxx.cion
}

timeout()
{
    waitfor=3
    command=$*
    $command &
    commandpid=$!
    ( sleep $waitfor ; kill -9 $commandpid > /dev/null 2>&1 && mailSend ) &
    watchdog=$!
    sleeppid=$PPID
    wait $commandpid > /dev/null 2>&1
    kill $sleeppid > /dev/null 2>&1
}

#测试的函数
test123()
{
    sleep 20
}

timeout test123

#超过timeout时间还没执行完，只发邮件告警，程序正常执行:
mailSend()
{
    mailContent="xxxxe Web response time over 5 seconds,Please have a check !"
    echo $mailContent | mail -s "xxxxx WEB response time over 5 senconds"
    $mailTo
}
timeout()
{
    waitfor=6
    command=$*
    $command &
    commandpid=$!
    ( sleep $waitfor ;  mailSend ) &
    watchdog=$!
    sleeppid=$PPID
    wait $commandpid > /dev/null 2>&1
    kill  -9 $watchdog > /dev/null 2>&1
    kill $sleeppid > /dev/null 2>&1
}
# Jstack Printer, JSTAZUA!!

**jstack의 간단한 parsing을 제공**

## 요약

- jstack dump file을 간단하게 요약하여 출력
 
## 기능



#### jstazua

```$xslt
jstazua [jstack dump file]
```

![jstazua](/images/jstzua.png)

- dump 파일을 요약하여 출력.

#### live-jstazua

```$xslt
live-jstazua [application name] [sleep per] [alias:optional]
```

![live-jstazua](/images/live-jstazua.png)

- Java Application 의 jstack dump를 지정한 주기로 생성.

![live-jstazua2](/images/live-jstazua2.png)

- 시간 + alias 경로에 생성

---

## TODO

- conf 파일로 exclude option 제공

> 상당히 미숙한 쉘 프로그램입니다. 많은 도움 부탁드립니다.

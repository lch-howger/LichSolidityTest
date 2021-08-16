package main

import (
	"fmt"
	"math/big"
	"strconv"
	"strings"
)

/**
1.攻击
2.防御
3.敏捷
4.命中率
5.运载量(无关)
6.速度(无关)
7.血量
8.类型
9.等级
10.质量
11.自我修复能力
12.冷却时间
*/

type Hero struct {
	attack   int
	defense  int
	agility  int
	accuracy int
	health   int
}

func main() {
	test04("0x01f4000000000000000001f4000000000000000000060000019040060000019000060000012c40060000012c")
}

func test04(rawHex string) {
	rawHex = noPrefix(rawHex)
	attackerHealth := rawHex[0:20]
	defenderHealth := rawHex[20:40]
	fmt.Printf("攻击者初始血量为:%v \n", attackerHealth)
	fmt.Printf("防御者初始血量为:%v \n", defenderHealth)

	arr := splitString(rawHex[40:], 12)
	for k, v := range arr {
		fmt.Printf("第%v回合, 数据为: %v \n", k+1, v)
	}
}

func splitString(str string, length int) []string {
	if len(str)%length == 0 {
		arr := []string{}
		tempString := ""
		split := strings.Split(str, "")
		for k, v := range split {
			tempString += v
			if k > 0 && (k+1)%length == 0 {
				arr = append(arr, tempString)
				tempString = ""
			}
		}
		return arr
	} else {
		return nil
	}
}

func noPrefix(rawHex string) string {
	if strings.HasPrefix(rawHex, "0x") {
		rawHex = rawHex[2:]
	}
	return rawHex
}

func test03(rawHex string) {
	if strings.HasPrefix(rawHex, "0x") {
		rawHex = rawHex[2:]
	}
	fmt.Println(rawHex)
	tempString := ""
	split := strings.Split(rawHex, "")
	count := 0
	for k, v := range split {
		tempString += v
		if k > 0 && (k-3)%4 == 0 {
			i := new(big.Int)
			i.SetString(tempString, 16)
			count++
			fmt.Printf("第%v回合,血量剩余%v,\n", count, i)
			tempString = ""
		}
	}
}

func test02(rawHex string) {
	if strings.HasPrefix(rawHex, "0x") {
		rawHex = rawHex[2:]
	}
	fmt.Println(rawHex)
	i, err := strconv.ParseUint(rawHex, 16, 32)
	if err != nil {
		fmt.Printf("%s", err)
	}
	fmt.Printf("%024b\n", i)
	fmt.Println(asBits(i))
}

func asBits(val uint64) []uint64 {
	bits := []uint64{}
	for i := 0; i < 24; i++ {
		bits = append([]uint64{val & 0x1}, bits...)
		val = val >> 1
	}
	return bits
}

func test01() {
	attacker := Hero{500, 100, 100, 100, 1000}
	defender := Hero{100, 100, 100, 100, 1000}

	count := 0
	for {
		count++
		damage, health := attack(&attacker, &defender)
		fmt.Printf("第%v回合,attacker进行攻击,造成%v点伤害,defender还剩余%v\n", count, damage, health)
		if defender.health <= 0 {
			fmt.Println("战斗结束,attacker获胜")
			break
		}

		count++
		damage, health = attack(&defender, &attacker)
		fmt.Printf("第%v回合,defender进行攻击,造成%v点伤害,attacker还剩余%v\n", count, damage, health)
		if attacker.health <= 0 {
			fmt.Println("战斗结束,defender获胜")
			break
		}
	}
}

func attack(attacker *Hero, defender *Hero) (int, int) {
	damage := attacker.attack + attacker.attack*attacker.accuracy/(attacker.attack+attacker.accuracy)
	resist := defender.defense + defender.defense*defender.agility/(defender.defense+defender.agility)

	realDamage := damage * damage / (damage + resist)
	defender.health -= realDamage

	return realDamage, defender.health
}

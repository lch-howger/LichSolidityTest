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
	test03("0x01a901a9015e015e0113011300c800c8007d007d003200320000")
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

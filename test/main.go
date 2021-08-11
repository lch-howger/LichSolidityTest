package main

import "fmt"

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
	Attack   uint
	Defense  uint
	Agility  uint
	Accuracy uint
	Health   uint
}

func main() {
	//attacker := Hero{100, 100, 100, 100, 100}
	//defender := Hero{100, 100, 100, 100, 100}

	test01()
}

func test01() {
	attacker := Hero{100, 100, 100, 100, 100}
	defender := Hero{100, 100, 100, 100, 100}

	count := 0
	for i := 0; i < 10; i++ {
		count++
		damage, health := attack(&attacker, &defender)
		fmt.Printf("第%v回合,attacker进行攻击,造成%v点伤害,defender还剩余%v \n", count, damage, health)
		if defender.Health <= 0 {
			fmt.Println("战斗结束,attacker获胜")
			break
		}

		count++
		damage, health = attack(&defender, &attacker)
		fmt.Printf("第%v回合,defender进行攻击,造成%v点伤害,attacker还剩余%v\n", count, damage, health)
		if attacker.Health <= 0 {
			fmt.Println("战斗结束,defender获胜")
			break
		}
	}
}

func attack(attacker *Hero, defender *Hero) (uint, uint) {
	defender.Health = defender.Health - attacker.Attack
	return attacker.Attack, defender.Health
}

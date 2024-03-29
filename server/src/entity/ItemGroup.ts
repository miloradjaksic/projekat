import { Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";


@Entity()
export class ItemGroup {

  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @ManyToOne(() => ItemGroup, g => g.children, { nullable: true, onDelete: 'SET NULL' })
  parentGroup?: ItemGroup;

  @OneToMany(() => ItemGroup, g => g.parentGroup)
  children: ItemGroup[]

}
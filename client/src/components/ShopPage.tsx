import React, { useState } from 'react'
import { Link } from 'react-router-dom';
import { FlexboxGrid } from 'rsuite';
import FlexboxGridItem from 'rsuite/esm/FlexboxGrid/FlexboxGridItem';
import useGet from '../hooks/useGet'
import { Item, ItemGroup, ItemsRes } from '../types'
import GroupFilter from './GroupFilter';
import ItemCard from './ItemCard';

function flattenGroups(itemGroups: ItemGroup[]) {
  let arr: ItemGroup[] = [];
  for (let group of itemGroups) {
    arr.push(group);
    if (group.children.length > 0) {
      arr.push(...flattenGroups(group.children))
    }
  }
  return arr;
}


export default function ShopPage() {
  const [selectedGroupId, setSelectedGroupId] = useState(0);
  const [groups] = useGet<ItemGroup[]>('/item-group', []);
  const [items] = useGet<ItemsRes | undefined>('/item', undefined, {
    groupId: selectedGroupId + ''
  });
  const flattened = flattenGroups(groups);
  function getGroupBreadcrumb(group?: ItemGroup): string {
    if (!group) {
      return '';
    }
    //@ts-ignore
    return getGroupBreadcrumb(flattened.find(e => e.id === group.parentGroup)) + ' - ' + group.name + '';
  }

  return (
    <FlexboxGrid >
      <FlexboxGridItem colspan={4}>
        <GroupFilter onSelect={setSelectedGroupId} itemGroups={groups} />
      </FlexboxGridItem>

      <FlexboxGridItem colspan={1}>
      </FlexboxGridItem>
      <FlexboxGridItem colspan={17}>
        <h2 style={{ textTransform: 'capitalize', textAlign: 'center' }}>
          {getGroupBreadcrumb(flattened.find(e => e.id == selectedGroupId)).substring(3)}
        </h2>
        <div
          style={{
            display: 'flex',
            flexWrap: 'wrap'
          }}
        >

          {
            (items?.data || []).map(item => {
              return (
                <div key={item.id} style={{ flexBasis: '33%', paddingRight: '40px', height: '100%' }}>
                  <Link style={{ height: '100%' }} to={`/item/${item.id}`}>
                    <ItemCard item={item} />
                  </Link>
                </div>
              )
            })
          }
        </div>
      </FlexboxGridItem>
    </FlexboxGrid>
  )
}

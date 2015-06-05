package com.ymz.restaurant.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ymz.common.util.PagingBean;
import com.ymz.restaurant.dao.RestaurantDAO;
import com.ymz.restaurant.vo.Food;
import com.ymz.restaurant.vo.Restaurant;

@Service
public class RestaurantServiceImpl implements RestaurantService {
	
	@Autowired
	private RestaurantDAO dao;
	
	@Override
	public Map<String, Object> getListByTypePaging(String category, String align, int currentPage, String searchWord) {
		List<Restaurant> list = dao.selectListByTypePaging(category, align, currentPage, searchWord);
		
		int totalContent = dao.selectRestaurantCountByCategory(category, searchWord);
		PagingBean pagingBean = new PagingBean(totalContent, currentPage);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("restaurantList", list);
		map.put("pagingBean", pagingBean);
		map.put("category", category);
		map.put("align", align);
		map.put("searchWord", searchWord);
		map.put("today", new SimpleDateFormat("yyyyMMdd").format(new Date()));
		return map;
	}
	
	@Override
	public Map<String, Object> getListByThemePaging(String theme, String align, int currentPage, String searchWord) {
		List<Restaurant> list = dao.selectListByThemePaging(theme, align, currentPage, searchWord);
		
		int totalContent = dao.selectRestaurantCountByTheme(theme, searchWord);
		PagingBean pagingBean = new PagingBean(totalContent, currentPage);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("restaurantList", list);
		map.put("pagingBean", pagingBean);
		map.put("theme", theme);
		map.put("align", align);
		map.put("searchWord", searchWord);
		map.put("today", new SimpleDateFormat("yyyyMMdd").format(new Date()));
		return map;
	}

	@Override
	public Restaurant getRestaurantByName(String name) {
		return dao.selectRestaurantByName(name);
	}

	@Override
	public List<String> getBuildingNames() {
		return dao.selectBuildingNames();
	}

	@Override
	public List<String> getFloorsByBuildingName(String buildingName) {
		return dao.selectFloorsByBuildingName(buildingName);
	}

	@Override
	public int getLocationNo(String buildingName, String floor) {
		return dao.selectLocationNo(buildingName, floor);
	}

	@Override
	@Transactional
	public void addRestaurant(Restaurant restaurant, String[] foodNames,
			String[] foodPrices, String[] foodDescriptions) {
		dao.insertRestaurant(restaurant);
		
		ArrayList<String> foodNamesList = new ArrayList<String>();
		ArrayList<Integer> foodPricesList = new ArrayList<Integer>();
		ArrayList<String> foodDescriptionsList = new ArrayList<String>();
		for(int i=0; i<foodNames.length; i++) {
			if(!foodNames[i].equals("")) {
				foodNamesList.add(foodNames[i]);
				foodPricesList.add(Integer.parseInt(foodPrices[i]));
				foodDescriptionsList.add(foodDescriptions[i]);
			}
		}
		
		for(int i=0; i<foodNamesList.size(); i++) {
			dao.insertFood(restaurant.getRestaurantNo(), foodNamesList.get(i), foodPricesList.get(i), foodDescriptionsList.get(i));
		}
	}

	@Override
	public Restaurant getRestaurantByNo(int restaurantNo) {
		return dao.selectRestaurantByNo(restaurantNo);
	}

	@Override
	public String getLocationByNo(int locationNo) {
		return dao.selectLocationByNo(locationNo);
	}

	@Override
	public List<Food> getFoodsByRestaurantNo(int restaurantNo) {
		return dao.selectFoodsByRestaurantNo(restaurantNo);
	}

	@Override
	public int increaseHits(int restaurantNo) {
		return dao.updateHits(restaurantNo);
	}

	@Override
	public List<String> getRestaurantsByBuildingName(String buildingName) {
		List<String> floors = dao.selectFloorsByBuildingName(buildingName);
		List<String> data = new ArrayList<String>();
		for(int i=0; i<floors.size(); i++) {
			List<Restaurant> restaurants = dao.selectRestaurantsByBuildingNameAndFloor(buildingName, floors.get(i));
			String temp = "";
			for(int j=0; j<restaurants.size(); j++) {
				temp += restaurants.get(j).getRestaurantName()+",";
			}
			data.add(floors.get(i)+"층");
			data.add(temp);
		}
		return data;
	}

	@Override
	public Map<String, Object> getRestaurantsPaging(String buildingName, String floor, String align, int currentPage, String searchWord) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<Restaurant> restaurants = dao.selectRestaurantsPaging(buildingName, floor.split("층")[0], align, currentPage, searchWord);
		map.put("restaurants", restaurants);
		
		int totalContent = dao.selectRestaurantCount(buildingName, floor.split("층")[0], searchWord);
		PagingBean pagingBean = new PagingBean(totalContent, currentPage);
		map.put("pagingBean", pagingBean);
		
		List<String> buildingNames = dao.selectBuildingNames();
		map.put("buildingNames", buildingNames);
		map.put("currentBuildingName", buildingName);
		map.put("currentFloor", floor.split("층")[0]);
		map.put("currentAlign", align);
		map.put("searchWord", searchWord);
		
		List<String> floors = dao.selectFloorsByBuildingName(buildingName);
		map.put("floors", floors);
		
		return map;
	}

	@Override
	public int removeRestaurant(int restaurantNo) {
		return dao.deleteRestaurant(restaurantNo);
	}

	@Override
	public Map setRestaurantModifyForm(int restaurantNo) {
		Map map = new HashMap();
		
		Restaurant restaurant = dao.selectRestaurantByNo(restaurantNo);
		map.put("restaurant", restaurant);
		map.put("buildingNames", dao.selectBuildingNames());
		String currentBuildingName = dao.selectBuildingNameByLocationNo(restaurant.getLocationNo());
		map.put("currentBuildingName", currentBuildingName);
		map.put("floors", dao.selectFloorsByBuildingName(currentBuildingName));
		map.put("currentFloor", dao.selectFloorByLocationNo(restaurant.getLocationNo()));
		return map;
	}
}

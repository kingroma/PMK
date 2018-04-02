package server.db.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.java.location.Location;

public interface LocationMapper {
	final String getLocationSql = "select * from location where location_number=#{location_number}";
	@Select(getLocationSql)
	public Location getLocation(int location_number);
	
	final String addLocationSql = "insert into location (location_number,name,imageUrl) values "
			+ "(#{location_number},#{name},#{imageUrl})";
	@Insert(addLocationSql)
	public int addLocation(Location location);
	
	
}

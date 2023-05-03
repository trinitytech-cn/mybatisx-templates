package ${mapperInterface.packageName};

import ${tableClass.fullClassName};
import org.apache.ibatis.annotations.Mapper;
import com.trinity.common.core.mapper.BaseMapperPlus;

/**
 * ${tableClass.remark!} Mapper
 *
 * @see ${tableClass.shortClassName}
 */
@Mapper
public interface ${mapperInterface.fileName} extends BaseMapperPlus<${mapperInterface.fileName}, ${tableClass.shortClassName}, ${tableClass.shortClassName}> {

}

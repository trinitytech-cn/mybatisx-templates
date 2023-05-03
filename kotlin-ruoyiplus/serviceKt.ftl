package ${baseInfo.packageName}

import ${tableClass.fullClassName}
import ${mapperInterface.packageName}.${mapperInterface.fileName}
import ${baseInfo.packageName}.BaseService
import org.springframework.stereotype.Service

/**
 * ${tableClass.remark!} Service
 *
 * [${tableClass.shortClassName}]
 */
@Service
class ${baseInfo.fileName}: BaseService<${mapperInterface.fileName}, ${baseInfo.fileName}>() {
}

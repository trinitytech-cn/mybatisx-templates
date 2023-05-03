<#function dashedToCamel(s)>
    <#return s
    ?replace('(^_+)|(_+$)', '', 'r')
    ?replace('\\_+(\\w)?', ' $1', 'r')
    ?replace('([A-Z])', ' $1', 'r')
    ?capitalize
    ?replace(' ' , '')
    ?uncap_first
    >
</#function>

<#function isExcluded(field)>
    <#return field.fieldName == "createBy" || field.fieldName == "createTime" || field.fieldName == "updateBy" || field.fieldName == "updateTime">
</#function>

<#function getType(field)>
    <#if field.jdbcType == "DATE">
        <#return "LocalDate">
    <#elseif field.jdbcType == "TIMESTAMP" || field.jdbcType == "TIME">
        <#return "LocalDateTime">
    <#elseif field.jdbcType == "TINYINT" && field.columnLength == 1>
        <#return "Boolean">
    <#elseif field.shortTypeName == "Integer">
        <#return "Int">
    <#elseif field.shortTypeName == "Object">
        <#return "Any">
    <#else>
        <#return field.shortTypeName>
    </#if>
</#function>
package ${domainKt.packageName}

import com.baomidou.mybatisplus.annotation.TableLogic
import com.baomidou.mybatisplus.annotation.TableName
import com.fasterxml.jackson.annotation.JsonProperty
import com.trinity.common.core.domain.BaseEntity
import com.trinity.common.core.validate.EditGroup
import java.time.LocalDate
import java.time.LocalDateTime
import javax.validation.constraints.NotBlank
import javax.validation.constraints.NotNull
import javax.validation.constraints.Size

/**
 * ${tableClass.remark!}
 */
@TableName("${tableClass.tableName}")
open class ${tableClass.shortClassName} : BaseEntity() {
<#list tableClass.allFields as field>
<#if !isExcluded(field)>
    <#assign fieldType = getType(field)>
    /**
     * ${field.remark!}
     */
    <#if field.fieldName == "id">
    @NotNull(message = "[${field.remark!}]不能为空", groups = [EditGroup::class])
    <#elseif !field.nullable && field.jdbcType=="VARCHAR">
    @NotBlank(message = "[${field.remark!}]不能为空")
    <#elseif !field.nullable && field.jdbcType!="VARCHAR">
    @NotNull(message = "[${field.remark!}]不能为空")
    </#if>
    <#if field.jdbcType == "VARCHAR" && 0 &lt; field.columnLength>
    @Size(max = ${field.columnLength?c}, message = "[${field.remark!}]长度不能超过${field.columnLength?c}")
    </#if>
    <#if field.fieldName == "deleteTime">
    @TableLogic(value = "NULL", delval = "NOW()")
    </#if>
    <#if field.fieldName?starts_with("is") && fieldType == "Boolean">
    @get:JsonProperty(value = "${field.fieldName}")
    </#if>
    var ${dashedToCamel(field.fieldName)}: ${fieldType}? = null

</#if>
</#list>
    companion object {
        const val BUSINESS_NAME = "${tableClass.remark!}"
    }
}

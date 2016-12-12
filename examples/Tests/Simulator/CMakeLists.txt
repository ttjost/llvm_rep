#
# Create by Hugo van der Wijst (TU Delft)
#

cmake_minimum_required (VERSION 2.6)
project (Simulator)

set( ISSUE_WIDTH_AS 8 )
set( ISSUE_WIDTH_EXEC 8 )

set( COMPILER llvm CACHE STRING "The compiler to compile with. Allowed values: \"llvm\"." )

# test if the compiler is supported
if( NOT COMPILER STREQUAL "llvm")
    message(FATAL_ERROR "Unknown compiler \"${COMPILER}\".")
endif()

set( LLVM_DIR ${CMAKE_SOURCE_DIR}/../../../../build/bin )
set( LLVM_CLANG ${LLVM_DIR}/clang )
set( LLVM_LLC ${LLVM_DIR}/llc )

set( VEX_BINUTILS_DIR ${CMAKE_SOURCE_DIR}/../../../../binutils-rvex )
set( VEX_AS ${VEX_BINUTILS_DIR}/gas/as-new )
set( VEX_LD ${VEX_BINUTILS_DIR}/ld/ld-new )
set( XSTSIM /home/jost/llvm_build/xstsim-r-VEX-1.1.3 )

set( CFLAGS -DCHECK_RESULTS=0 )

if( ISSUE_WIDTH_AS EQUAL 2 )
    set( AS_FLAGS --config 7B --borrow 1.0. --defsym FUNC_UNDERSCORED=${FUNC_UNDERSCORED} )
elseif( ISSUE_WIDTH_AS EQUAL 4 )
    set( AS_FLAGS --config 337B --borrow 1.0.3,0.2,1 --defsym FUNC_UNDERSCORED=${FUNC_UNDERSCORED} )
elseif( ISSUE_WIDTH_AS EQUAL 8 )
    set( AS_FLAGS --config 7373737B --borrow 1.0.3.2.5.4.7.6 --defsym FUNC_UNDERSCORED=${FUNC_UNDERSCORED} )
else()
    message(FATAL_ERROR "Incorrect issue width \"${COMPILER}\".")
endif()

set( LD_FLAGS -T ${CMAKE_SOURCE_DIR}/zedboard.cmd )

#
# LLVM via Clang IR
#
function(add_ir_llvm opt_lvl result source)
    add_custom_command(
        OUTPUT ${result}
        COMMAND ${LLVM_CLANG} -O${opt_lvl} ${CFLAGS} -emit-llvm -S -m32 -fno-stack-protector ${source} -o ${result}
        DEPENDS ${source}
    )
endfunction()

function(add_assembly_llvm opt_lvl result source)
    add_custom_command(
        OUTPUT ${result}
        COMMAND ${LLVM_LLC} -march=vex -mcpu=rvex-${ISSUE_WIDTH_AS}issue ${source} -o ${result}
        DEPENDS ${source}
    )
endfunction()

#
# Create object file from assembly
#
function(add_object result source)
    add_custom_command(
        OUTPUT ${result}
        COMMAND ${VEX_AS} --issue ${ISSUE_WIDTH_AS} -o ${result} ${source} ${AS_FLAGS}
        DEPENDS ${source}
    )
endfunction()

function(add_exec result) # sources in ARGN
    add_custom_command(
        OUTPUT ${result}
        COMMAND ${VEX_LD} ${LD_FLAGS} -o ${result} ${ARGN}
        DEPENDS ${source} ${ARGN}
    )
endfunction(add_exec)

function(add_simu desc result source)
    add_custom_command(
        OUTPUT ${result}
        COMMAND
            timeout 60s ${XSTSIM} --ips='"[r-VEX c]"' --c.trace=5 --c.trace_regs=2 --c.core.issue_width=${ISSUE_WIDTH_EXEC}
            --c.subsystem.ramsize=0x8000000 --accuracy=0 --c.target_exec='"${source}"' 
            | grep -e "'\# [0-9]* / [0-9]* @ [0-9.]*'" -e "'r0.3  = *[0-9a-f]*'" -o 
            | sed "'s/.*\# \\([0-9][0-9]*\\) \\/ \\([0-9][0-9]*\\) \\@ \\([0-9][0-9.]*\\)/\\1\\t\\2\\t\\3/'"
            | tail -n3
            | perl -0777 -pe "'s/([^\\n]*)\\n([^\\n]*)\\nr0.3" *= "*([0-9a-f]+)/${desc}\\t\\2\\t\\3/g'"
            > ${result}
        DEPENDS ${source}
    )
endfunction(add_simu)

function(combine_results result) # sources in ARGN
    add_custom_command(
        OUTPUT ${result}
        COMMAND cat ${ARGN} > ${result}
        DEPENDS ${ARGN}
    )
endfunction()

function(add_assembly opt_lvl result_we source)
    if(COMPILER STREQUAL "llvm")
        add_ir_llvm(${opt_lvl} ${result_we}.ll ${source})
        add_assembly_llvm(${opt_lvl} ${result_we}.s ${result_we}.ll)
    else()
        message(FATAL_ERROR "Unknown rule to create assembly for \"${COMPILER}\".")
    endif()
endfunction()

function(compiler_max_opt_lvl opt_lvl_var)
    if(COMPILER STREQUAL "llvm")
        set(${opt_lvl_var} 3 PARENT_SCOPE)
    else()
        message(FATAL_ERROR "Unknown maximum optimization level for \"${COMPILER}\".")
    endif()
endfunction()

function(add_simu_from_source result)
    set(out_dir ${result})

    compiler_max_opt_lvl(max_opt_lvl)

    file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/${out_dir})
    foreach (opt_lvl RANGE ${max_opt_lvl})
        set(result_file_we ${out_dir}/${result}_${opt_lvl})

        # clear obj_files array
        set(obj_files )

        foreach (out_file ${ARGN} ${CMAKE_SOURCE_DIR}/memset.c)
            get_filename_component(out_we ${out_file} NAME_WE)
            set(out_file_we ${out_dir}/${out_we}_${opt_lvl})

            add_assembly(${opt_lvl} ${out_file_we} ${out_file})
            add_object(${out_file_we}.o ${out_file_we}.s)
            list(APPEND obj_files ${out_file_we}.o)
        endforeach()

        add_object(_start.o ${CMAKE_SOURCE_DIR}/_start.s)
        add_exec(${result_file_we}.exec ${obj_files} _start.o )
        add_simu("${result}\\t${opt_lvl}" ${result_file_we}.out ${result_file_we}.exec)

        list(APPEND simu_results ${result_file_we}.out)
    endforeach()

    combine_results(${result}.simu ${simu_results})

    add_custom_target(${result} ALL DEPENDS ${result}.simu ${srecs} ${disas})
endfunction(add_simu_from_source)

#add_simu_from_source(arit ${CMAKE_SOURCE_DIR}/arit.c)
add_simu_from_source(adpcm ${CMAKE_SOURCE_DIR}/powerstone/adpcm.c)
add_simu_from_source(bcnt ${CMAKE_SOURCE_DIR}/powerstone/bcnt.c)
add_simu_from_source(blit ${CMAKE_SOURCE_DIR}/powerstone/blit.c)
#add_simu_from_source(compress ${CMAKE_SOURCE_DIR}/powerstone/compress.c)
add_simu_from_source(crc ${CMAKE_SOURCE_DIR}/powerstone/crc.c)
add_simu_from_source(engine ${CMAKE_SOURCE_DIR}/powerstone/engine.c)
add_simu_from_source(g3fax ${CMAKE_SOURCE_DIR}/powerstone/g3fax.c)
add_simu_from_source(jpeg ${CMAKE_SOURCE_DIR}/powerstone/jpeg.c)
add_simu_from_source(pocsag ${CMAKE_SOURCE_DIR}/powerstone/pocsag.c)
add_simu_from_source(ucbqsort ${CMAKE_SOURCE_DIR}/powerstone/ucbqsort.c)
add_simu_from_source(v42 ${CMAKE_SOURCE_DIR}/powerstone/v42.c)

#add_simu_from_source(img ${CMAKE_SOURCE_DIR}/img/main.c ${CMAKE_SOURCE_DIR}/img/image1.c ${CMAKE_SOURCE_DIR}/img/result_image.c ${CMAKE_SOURCE_DIR}/img/filter.c)

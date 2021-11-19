#!/usr/bin/env bash
set -e

. $IDF_PATH/export.sh

if [ $1 == "test" ] ; then

echo "EXECUTING TEST"
    case $2 in
        test_certificate_bundle_on_host)
            cd /opt/esp/idf/components/mbedtls/esp_crt_bundle/test_gen_crt_bundle/
            ./test_gen_crt_bundle.py
            ;;

        test_confgen)
            cd /opt/esp/idf/tools/kconfig_new/test/confgen/
            ./test_confgen.py
            ;;

        test_confserver)
            pip install pexpect

            cd /opt/esp/idf/tools/kconfig_new/test/confserver
            ./test_confserver.py
            ;;

        test_cxx_gpio)

            apt-get update
            apt-get -y install ruby-full

            cd ${IDF_PATH}/examples/cxx/experimental/experimental_cpp_component/host_test/gpio
            idf.py build
            build/test_gpio_cxx_host.elf
            ;;

        test_detect_python)
            apt-get update
            apt-get -y install fish
            apt-get -y install zsh
            apt-get -y install shellcheck

            cd ${IDF_PATH}
            shellcheck -s sh tools/detect_python.sh
            shellcheck -s bash tools/detect_python.sh
            shellcheck -s dash tools/detect_python.sh
            bash -c '. tools/detect_python.sh && echo Our Python: ${ESP_PYTHON?Python is not set}'
            dash -c '. tools/detect_python.sh && echo Our Python: ${ESP_PYTHON?Python is not set}'
            zsh -c '. tools/detect_python.sh && echo Our Python: ${ESP_PYTHON?Python is not set}'
            fish -c 'source tools/detect_python.fish && echo Our Python: $ESP_PYTHON'
            ;;


        test_efuse_table_on_host_esp32)

            export IDF_TARGET=esp32
            ./efuse_table_gen.py -t "${IDF_TARGET}" ${IDF_PATH}/components/efuse/${IDF_TARGET}/esp_efuse_table.csv
            git diff --exit-code -- ${IDF_TARGET}/esp_efuse_table.c || { echo 'Differences found for ${IDF_TARGET} target. Please run make efuse_common_table or idf.py efuse-common-table and commit the changes.'; exit 1; }
            cd ${IDF_PATH}/components/efuse/test_efuse_host
            ./efuse_tests.py
            ;;

        test_efuse_table_on_host_esp32c3)

            ?
            ;;

        test_efuse_table_on_host_esp32h2)

            ?
            ;;

        test_efuse_table_on_host_esp32s2)

            ?
            ;;

        test_efuse_table_on_host_esp32s3)

            ?
            ;;

        test_eh_frame_parser)

            apt-get update
            apt-get install libbsd-dev

            cd ${IDF_PATH}/components/esp_system/test_eh_frame_parser
            make

            …… ????
            ;;

        test_esp_coredump)

            ?
            ;;

        test_esp_event)

            apt-get update
            apt-get install ruby-full
            apt-get install libbsd-dev

            cd ${IDF_PATH}/components/esp_event/host_test/esp_event_unit_test
            idf.py build
            build/test_esp_event_host.elf
            ;;


        test_esp_timer_cxx)

            apt-get update
            apt-get install ruby-full

            cd ${IDF_PATH}/examples/cxx/experimental/experimental_cpp_component/host_test/esp_timer
            idf.py build
            build/test_esp_timer_cxx_host.elf
            ;;

        test_fatfsgen_on_host)

            cd $IDF_PATH/components/fatfs/test_fatfsgen/
            ./test_fatfsgen.py
            ;;

        test_fatfs_on_host)

            Apt-get update
            apt-get install libbsd-dev

            cd $IDF_PATH/components/fatfs/test_fatfs_host/
            make test
            ;;

        test_gen_kconfig_doc)

            cd $IDF_PATH/tools/kconfig_new/test/gen_kconfig_doc/
            ./test_target_visibility.py
            ./test_kconfig_out.py
            ;;

        test_i2c_cxx)

            apt-get update
            apt-get install ruby-full

            cd ${IDF_PATH}/examples/cxx/experimental/experimental_cpp_component/host_test/i2c
            Idf.py build
            build/test_i2c_cxx_host.elf
            ;;

        test_idf_monitor)

            cd ${IDF_PATH}/tools/test_idf_monitor
            ./run_test_idf_monitor.py
            ;;

        test_idf_py)

            cd ${IDF_PATH}/tools/test_idf_py
            ./test_idf_py.py
            ;;

        test_idf_size)

            pip install coverage

            cd ${IDF_PATH}/tools/test_idf_size
            ./test.sh
            ;;

        test_idf_tools)

            export PATH=$(p=$(echo $PATH | tr ":" "\n" | grep -v "/root/.espressif/tools\|/opt/espressif" | tr "\n" ":"); echo ${p%:})
            cd ${IDF_PATH}/tools/test_idf_tools
            ./test_idf_tools.py
            cd ${IDF_PATH}/tools
            python3 ./idf_tools.py install-python-env
            ;;

        test_ldgen_on_host)

            cd $IDF_PATH/tools/ldgen/test
            ./test_fragments.py
            ./test_generation.py
            ./test_entity.py
            ./test_output_commands.py
            ;;

        test_linux_example)

            apt-get update
            apt-get install ruby-full

            cd ${IDF_PATH}/examples/build_system/cmake/linux_host_app
            Idf.py build
            timeout 5 ./build/linux_host_app.elf >test.log || true
            grep "Restarting" test.log
            ;;

        test_log)

            cd ${IDF_PATH}/components/log/host_test/log_test
            idf.py build
            build/test_log_host.elf

            test_logtrace_proc

            pip install coverage

            cd ${IDF_PATH}/tools/esp_app_trace/test/logtrace
            ./test.sh
            ;;

        test_mkdfu)

            pip install pexpect

            cd ${IDF_PATH}/tools/test_mkdfu
            ./test_mkdfu.py
            ;;

        test_mkuf2)

            pip install pexpect

            cd ${IDF_PATH}/tools/test_mkuf2
            ./test_mkuf2.py
            ;;

        test_multi_heap_on_host)

            apt-get update
            apt-get install libbsd-dev

            cd $IDF_PATH/components/heap/test_multi_heap_host
            ./test_all_configs.sh
            ;;

        test_nvs_on_host)

            cd $IDF_PATH/components/nvs_flash/test_nvs_host
            make test
            ;;

        test_nvs_page)

            apt-get update
            apt-get install ruby

            cd ${IDF_PATH}/components/nvs_flash/host_test/nvs_page_test
            idf.py build
            build/test_nvs_page_host.elf
            ;;

        test_partition_table)

            cd $IDF_PATH/components/partition_table/test_gen_esp32part_host
            ./gen_esp32part_tests.py
            ;;

        test_reproducible_build)

            Cd $IDF_PATH
            ./tools/ci/test_reproducible_build.sh
            ;;
        
        test_rom_on_linux)

            cd ${IDF_PATH}/components/esp_rom/host_test/rom_test
            idf.py build
            build/test_rom_host.elf
            ;;


        test_spi_cxx)

            apt-get update
            apt-get install ruby-full

            cd ${IDF_PATH}/examples/cxx/experimental/experimental_cpp_component/host_test/spi
            idf.py build
            build/test_spi_cxx_host.elf
            ;;

        test_spiffs_on_host)

            Apt-get update
            apt-get install libbsd-dev


            cd $IDF_PATH/components/spiffs/test_spiffs_host/
            make test
            cd ../test_spiffsgen
            ./test_spiffsgen.py
            ;;

        test_system_cxx)

            apt-get update
            apt-get install ruby-full

            cd /opt/esp/idf/examples/cxx/experimental/experimental_cpp_component/host_test/system
            idf.py build
            build/test_system_cxx_host.elf
            ;;

        test_sysviewtrace_proc)

            pip install coverage

            cd ${IDF_PATH}/tools/esp_app_trace/test/sysview
            ./test.sh
            ;;

        test_wl_on_host)

            Apt-get update
            apt-get install libbsd-dev

            cd $IDF_PATH/components/wear_levelling/test_wl_host
            make test
            ;;

    esac
fi

exec "$@"

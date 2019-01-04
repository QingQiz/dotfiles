#include <curl/curl.h>
#include <ctime>
#include <fstream>
#include <functional>
#include <iostream>
#include <random>
#include <string>

using std::ofstream;
using std::string;

class URL {
    CURL* handle;
    curl_slist* http_header;
    string post;
    string url;
    ofstream* fout;
    CURLcode status;

   public:
    URL() : http_header(nullptr), post(), url(), status(CURLE_OK) {
        handle = curl_easy_init();
        if (handle == nullptr) {
            status = CURLE_FAILED_INIT;
            return;
        }
    }
    void setHttpHeader() {
        if (status != CURLE_OK) return;
#define SET(x) http_header = curl_slist_append(http_header, x)
        SET("User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:61.0) "
            "Gecko/20100101 Firefox/61.0");
        SET("Accept: "
            "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
        SET("Accept-Language: en-US,en;q=0.5");
        SET("Accept-Encoding: gzip, deflate");
        SET("Connection: keep-alive");
        SET("Referer: http://detectportal.firefox.com/success.txt");
#undef SET

        curl_easy_setopt(handle, CURLOPT_HTTPHEADER, http_header);
    }
    void setURL(string addr) {
        if (status != CURLE_OK) return;
        url = addr;
        curl_easy_setopt(handle, CURLOPT_URL, url.c_str());
    }
    void setOutFunc(size_t (*wf)(void*, size_t, size_t, void*) =
                        [](void* buffer, size_t size, size_t nmemb,
                           void* userp) -> size_t {
        reinterpret_cast<ofstream*>(userp)->write(
            reinterpret_cast<char*>(buffer), size * nmemb);
        // std::cout << (char *)buffer << std::endl;
        return size * nmemb;
    }) {
        if (status != CURLE_OK) return;
        curl_easy_setopt(handle, CURLOPT_WRITEFUNCTION, *wf);
    }
    void setPost(string Pin) {
        if (status != CURLE_OK) return;
        post = Pin;
        curl_easy_setopt(handle, CURLOPT_POSTFIELDS, post.c_str());
    }
    void setDataWirter(string savePath) {
        if (status != CURLE_OK) return;
        fout = new ofstream(savePath,
                            ofstream::app | ofstream::out | ofstream::binary);
        if (!(*fout)) {
            status = CURLE_READ_ERROR;
            return;
        }
        curl_easy_setopt(handle, CURLOPT_WRITEDATA, fout);
    }
    void TimeOut(long to) {
        if (status != CURLE_OK) return;
        curl_easy_setopt(handle, CURLOPT_TIMEOUT, to);
    }
    CURLcode request() {
        if (status != CURLE_OK) return status;
        CURLcode ret = curl_easy_perform(handle);
        if (ret != CURLE_OK) {
            fout->close();
            return ret;
        }
        fout->close();
        return ret;
    }
    bool success() { return status != CURLE_OK ? false : true; }
};

int main(int argc, char* argv[]) {
    if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK) {
        puts("FAILED");
        return -1;
    }

    string url[2];
    url[0] = "http://202.117.80.138:8080/portal/pws?t=";
    url[1] = "http://202.117.80.137:8080/portal/pws?t=";
    string custom_post = "userName=2017302344&userPwd=MDQwNDU5MTI=";
    string save_path = "/dev/null";

    URL handle;
    int action = 1, urlUse = 0;
    if (argc == 1 || string(argv[1]) == "login" || string(argv[1]) == "i") {
        url[0] += "li";
        url[1] += "li";
        if (argc == 3 && string(argv[2]) == "once") action = 0;
    } else if (string(argv[1]) == "logout" || string(argv[1]) == "o") {
        url[0] += "lo";
        url[1] += "lo";
        action = 0;
    } else {
        std::cout << "ruijie_login: invalid option " << argv[1] << std::endl;
        puts("Usage: option i(login) to login or o(logout) to logout");
        puts(
            "\nExample:\n\t`ruijie_login i`\t\tto keep login\n\t`ruijie_login i"
            " once`\t\tto login in once");
        return -1;
    }

    handle.setHttpHeader();
    handle.setURL(url[urlUse]);
    handle.setPost(custom_post);
    handle.setOutFunc([](void*, size_t, size_t, void*) -> size_t { return 0; });
    handle.setDataWirter(save_path);
    handle.TimeOut(2L);

    if (!handle.success()) {
        puts("FAILED");
        return -1;
    }

    CURLcode check;
    if (action == 0) {
        check = handle.request();
        handle.setURL(url[urlUse ^ 1]);
        check = handle.request();
        return 0;
    }

    int cnt = 0;
    std::default_random_engine e(clock());
    while (true) {
        std::cout << ++cnt << ": ";
        check = handle.request();
        if (check == CURLE_OPERATION_TIMEDOUT) {
            puts("WARNING: TIMEOUT, Try Another IP");
            urlUse ^= 1;
            handle.setURL(url[urlUse]);
            std::system("sleep 0.2");
        } else {
            // e.seed(clock());
            // std::system(("sleep " + std::to_string(e() % 29)).c_str());
            puts("success.");
            std::system("sleep 15");
        }
    }
    return 0;
}

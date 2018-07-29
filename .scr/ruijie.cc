#include <iostream>
#include <string>
#include <curl/curl.h>
#include <functional>
#include <fstream>

using std::string;
using std::ofstream;

class URL {
    CURL* handle;
    curl_slist* http_header;
    string post;
    string url;
    ofstream* fout;
    int status;
public:
    URL(): http_header(nullptr), post(), url(), status(0) {
        handle = curl_easy_init();
        if (handle == nullptr) {
           status = -1;
            return;
        }
    }
    void setHttpHeader() {
        if (status == -1) return;
#define SET(x) http_header = curl_slist_append(http_header, x)
        SET("User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0");
        SET("Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
        SET("Accept-Language: en-US,en;q=0.5");
        SET("Accept-Encoding: gzip, deflate");
        SET("Connection: keep-alive");
        SET("Referer: http://detectportal.firefox.com/success.txt");
#undef SET

        curl_easy_setopt(handle, CURLOPT_HTTPHEADER, http_header);
    }
    void setURL(string addr) {
        if (status == -1) return;
        url = addr;
        curl_easy_setopt(handle, CURLOPT_URL, url.c_str());
    }
    void setOutFunc(size_t(*wf)(void*, size_t, size_t, void*) =
            [](void* buffer, size_t size, size_t nmemb, void* userp) -> size_t {
                reinterpret_cast<ofstream*>(userp)->write(reinterpret_cast<char*>(buffer), size * nmemb);
                // std::cout << (char *)buffer << std::endl;
                return size * nmemb;
            })
    {
        if (status == -1) return;
        curl_easy_setopt(handle, CURLOPT_WRITEFUNCTION, *wf);
    }
    void setPost(string Pin) {
        if (status == -1) return;
        post = Pin;
        curl_easy_setopt(handle, CURLOPT_POSTFIELDS, post.c_str());
    }
    void setDataWirter(string savePath) {
        if (status == -1) return;
        fout = new ofstream(savePath, ofstream::app | ofstream::out | ofstream::binary);
        if (!(*fout)) {
            status = -1;
            return;
        }
        curl_easy_setopt(handle, CURLOPT_WRITEDATA, fout);
    }
    void request() {
        if (status == -1) return;
        CURLcode ret = curl_easy_perform(handle);
        if (ret != CURLE_OK) {
            fout -> close();
            return;
        }
        fout -> close();
    }
    bool success() { return status == -1 ? false : true; }
};


int main(int argc, char *argv[]) {
    if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK) {
        puts("FAILED");
        return -1;
    }

    string url = "http://202.117.80.137:8080/portal/pws?t=";
    string custom_post = "userName=2017302344&userPwd=MDQwNDU5MTI=";
    string save_path = "./test";

    URL handle;
    int action = 1;
    if (argc == 1 || string(argv[1]) == "login" || string(argv[1]) == "i")
        url += "li";
    else if (string(argv[1]) == "logout" || string(argv[1]) == "o") {
        url += "lo";
        action = 0;
    } else {
        puts("FAILED");
        return -1;
    }

    handle.setHttpHeader();
    handle.setURL(url);
    handle.setPost(custom_post);
    handle.setOutFunc([](void*, size_t, size_t, void*) -> size_t { return 0; });
    handle.setDataWirter(save_path);

    if (!handle.success()) { puts("FAILED"); return -1; }
    if (action == 0) { handle.request(); return 0; }

    while (true) {
        handle.request();
        std::system("sleep 1800");
    }
    return 0;
}

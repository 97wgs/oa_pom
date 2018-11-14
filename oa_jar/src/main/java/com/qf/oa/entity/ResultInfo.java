package com.qf.oa.entity;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/7 10:38
 * @Version 1.0
 *

 *
 * {"a":1, "b":2}
 *
 * class Test{
 *     private int a;
 *     private int b;
 *     private List<Integer> c;
 * }
 *
 * [{“a”:1, "b":2, "c":[1,2,3]}, {“a”:1, "b":2, "c":[1,2,3]}, {“a”:1, "b":2, "c":[1,2,3]}]
 *
 * List<Test>
 *
 * {
 *   suggestions: [
 *      { "value": "United Arab Emirates", "data": "AE" },
 *      { "value": "United Kingdom",       "data": "UK" },
 *      { "value": "United States",        "data": "US" }
 *    ]
 * }
 *
 */
public class ResultInfo {

    private List<Info> suggestions;


    public static class Info{
        private String value;
        private String data;

        public String getValue() {
            return value;
        }

        public void setValue(String value) {
            this.value = value;
        }

        public String getData() {
            return data;
        }

        public void setData(String data) {
            this.data = data;
        }
    }

    public List<Info> getSuggestions() {
        return suggestions;
    }

    public void setSuggestions(List<Info> suggestions) {
        this.suggestions = suggestions;
    }
}

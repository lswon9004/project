<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>달력</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .prev-month, .next-month {
            color: #ccc;
        }
    </style>
</head>
<body>
    <%
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);
        cal.set(year, month, 1);
        int startDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
        int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        // 이전 달의 마지막 날
        Calendar prevCal = (Calendar) cal.clone();
        prevCal.add(Calendar.MONTH, -1);
        int prevLastDay = prevCal.getActualMaximum(Calendar.DAY_OF_MONTH);

        // 다음 달의 첫 번째 날
        Calendar nextCal = (Calendar) cal.clone();
        nextCal.add(Calendar.MONTH, 1);
    %>
    <h2><%= year %>년 <%= month + 1 %>월 달력</h2>
    <table>
        <thead>
            <tr>
                <th>일</th>
                <th>월</th>
                <th>화</th>
                <th>수</th>
                <th>목</th>
                <th>금</th>
                <th>토</th>
            </tr>
        </thead>
        <tbody>
            <%
                int day = 1;
                int prevDay = prevLastDay - startDayOfWeek + 2;
                boolean nextMonth = false;

                for (int i = 1; i <= 6; i++) {
                    out.println("<tr>");
                    for (int j = 1; j <= 7; j++) {
                        if (i == 1 && j < startDayOfWeek) {
                            out.println("<td class='prev-month'>" + prevDay + "</td>");
                            prevDay++;
                        } else if (day > lastDay) {
                            out.println("<td class='next-month'>" + (day - lastDay) + "</td>");
                            day++;
                        } else {
                            out.println("<td>" + day + "</td>");
                            day++;
                        }
                    }
                    out.println("</tr>");
                }
            %>
        </tbody>
    </table>
</body>
</html>

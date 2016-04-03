package by.gstu.interviewstreet.dao;

import by.gstu.interviewstreet.domain.Interview;
import by.gstu.interviewstreet.domain.User;
import by.gstu.interviewstreet.domain.UserInterview;

import java.util.List;


public interface IInterviewDAO {

    List<Interview> getAll();

    List<UserInterview> getUserInterviews(User user);

    Interview getById(int id);

    Interview getByHash(String hash);

    void save(Interview interview);

    void remove(Interview interview);

    void lockOrUnlock(int interviewId);

}

package by.gstu.interviewstreet.dao.impl;

import by.gstu.interviewstreet.dao.IInterviewDAO;
import by.gstu.interviewstreet.domain.Interview;
import by.gstu.interviewstreet.domain.User;
import by.gstu.interviewstreet.domain.UserInterview;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.List;

@Repository
public class InterviewDAOImpl implements IInterviewDAO {

    @Autowired
    SessionFactory sessionFactory;

    @Override
    @SuppressWarnings("unchecked")
    public List<Interview> getAllInterviews() {
        return sessionFactory.getCurrentSession().createQuery("from Interview")
                .list();
    }

    @Override
    public Interview getInterviewById(int id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Interview WHERE id = :id");
        query.setInteger("id", id);

        return (Interview) query.uniqueResult();
    }

    @Override
    public int insertInterview(Interview interview) {
        Serializable result = sessionFactory.getCurrentSession().save(interview);
        if (result != null) {
            return (Integer) result;
        }
        return -1;
    }

    @Override
    public void insertInterview(Interview interview, List<User> users) {
        int id = insertInterview(interview);
        interview.setId(id);

        Session session = sessionFactory.getCurrentSession();
        for (User user : users) {
            session.save(new UserInterview(interview, user));
        }
    }

    @Override
    public void removeInterviews(int[] interviewIds) {
        Session session = sessionFactory.getCurrentSession();
        for (int id : interviewIds) {
            Interview interview = (Interview) session.load(Interview.class, id);
            if (null != interview) {
                session.delete(interview);
            }
        }
    }

    @Override
    public void hideInterview(int interviewId) {
        Session session = sessionFactory.getCurrentSession();
        Interview interview = (Interview) session.load(Interview.class, interviewId);
        if (null != interview) {
            boolean hidden = !interview.isHide();
            interview.setHide(hidden);
            session.save(interview);
        }
    }
}

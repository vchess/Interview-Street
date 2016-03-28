package by.gstu.interviewstreet.dao.impl;

import by.gstu.interviewstreet.dao.IQuestionDAO;
import by.gstu.interviewstreet.domain.Question;
import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.List;

@Repository
public class QuestionDAOImpl extends AbstractDbDAO implements IQuestionDAO {

    @Override
    public Question insert(Question question) {
        getSession().save(question);
        return question;
    }

    @Override
    public Question qetById(int id) {
        return (Question) getSession()
                .createQuery("FROM Question WHERE id = :id")
                .setInteger("id", id)
                .uniqueResult();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Question> qet(List<Integer> ids) {
        return getSession()
                .createQuery("FROM Question WHERE id IN (:ids) ")
                .setParameterList("ids", ids)
                .list();
    }

    @Override
    public void remove(Question question) {
        if (question != null) {
            getSession().delete(question);
        }
    }

}
